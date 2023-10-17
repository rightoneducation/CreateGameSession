import Foundation
import AWSLambdaRuntime
import AWSLambdaEvents
import GraphQLClient

struct Request: Codable {
    let gameId: Int
    let isAdvancedMode: Bool
}

struct RequestError: Encodable {
    private let encoder = JSONEncoder()

    var error: String

    enum CodingKeys: String, CodingKey {
        case error
    }

    var json: String {
        guard
            let errorJSON = try? encoder.encode(error),
            let errorJSONString = String(data: errorJSON, encoding: .utf8) else {
            return
"""
{
    "message": "Failed to decode the error message". This should never happens.
}
"""
        }

        return errorJSONString
    }
}

enum APIError: Error, CustomStringConvertible, LocalizedError {
    case missingWrongAnswers
    case gameWithNoQuestions
    case oops

    var description: String {
        self.localizedDescription
    }

    var errorDescription: String? {
        switch self {
        case .missingWrongAnswers:
            return "For simple mode, all questions of the game are required to have a wrong answers in choices"
        case .gameWithNoQuestions:
            return "The chosen game has no questions associated to it."
        case .oops:
            return "Something went wrong"
        }
    }
}

let jsonEncoder = JSONEncoder()
let jsonDecoder = JSONDecoder()

Lambda.run { (context, request: APIGateway.V2.Request, callback: @escaping (Result<APIGateway.V2.Response, Error>) -> Void) in
    Task {
        let stage = request.context.stage
        guard
            request.context.http.path.hasSuffix("/createGameSession"),
            case .POST = request.context.http.method
        else {
            callback(.success(.init(
                statusCode: .badRequest,
                body: RequestError(error: "Invalid request: \(request.context.http.method): \(request.context.http.path)").json)))
            return
        }

        guard
            let body = request.body,
            let data = body.data(using: .utf8),
            let request = try? jsonDecoder.decode(Request.self, from: data)
        else {
            callback(.success(.init(
                statusCode: .badRequest,
                body: RequestError(error: "Failed to parse the request body.").json)))
            return
        }

        do {
            let gameSession = try await createGameSession(gameId: request.gameId, isAdvancedMode: request.isAdvancedMode, stage: stage)
            callback(.success(
                .init(
                    statusCode: .created,
                    headers: ["content-type": "application/json"],
                    body: try jsonEncoder.encodeAsString(gameSession))))
        } catch {
            let errorMessage = "\(context.requestID) \(error.localizedDescription)"
            context.logger.error(.init(stringLiteral: errorMessage))
            callback(.success(.init(
                statusCode: .internalServerError,
                body: RequestError(error: error.localizedDescription).json)))
        }
    }
}

func createGameSession(gameId: Int, isAdvancedMode: Bool, stage: String) async throws-> GameSession {
    let api = ClientAPI(stage: stage)
    let game = try await api.fetchGameAsync(id: gameId)

    let totalAnswersPerQuestion = 4

    guard !game.questions.isEmpty else {
        throw APIError.gameWithNoQuestions
    }

    if
        !isAdvancedMode,
        game.questions.map({ $0.choices.count }).reduce(0, +) != game.questions.count * totalAnswersPerQuestion
    {
        throw APIError.missingWrongAnswers
    }

    var gameCode: Int = 0

    while true {
        guard let code = (1000...9999).randomElement() else {
            throw APIError.oops
        }

        let existingGameSessions = try await api.fetchGameSessionBy(gameCode: code)

        if existingGameSessions.isEmpty {
            gameCode = code
            break
        }
    }

    let gameSession = try await api.createGameSession(for: game, with: gameCode, isAdvanceMode: isAdvancedMode)

    return gameSession
}
