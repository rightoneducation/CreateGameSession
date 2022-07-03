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

enum APIError: Error {
    case missingWrongAnswers
    case oops
}

let jsonEncoder = JSONEncoder()
let jsonDecoder = JSONDecoder()

Lambda.run { (context, request: APIGateway.V2.Request, callback: @escaping (Result<APIGateway.V2.Response, Error>) -> Void) in
    Task {
        guard
            request.context.http.path.hasSuffix("/createGameSession"),
            case .POST = request.context.http.method
        else {
            callback(.success(.init(
                statusCode: .badRequest,
                body: RequestError(error: "Invalud request: \(request.context.http.method): \(request.context.http.path)").json)))
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
            let gameSession = try await createGameSession(gameId: request.gameId, isAdvancedMode: request.isAdvancedMode)
            callback(.success(
                .init(
                    statusCode: .created,
                    headers: ["content-type": "application/json"],
                    body: try jsonEncoder.encodeAsString(gameSession))))
        } catch {
            callback(.success(.init(
                statusCode: .internalServerError,
                body: RequestError(error: error.localizedDescription).json)))
        }
    }
}

func createGameSession(gameId: Int, isAdvancedMode: Bool) async throws-> GameSession {
    let api = ClientAPI()
    let game = try await api.fetchGameAsync(id: gameId)

    if
        isAdvancedMode == false,
        game.questions.compactMap({ $0.wrongAnswers }).count == game.questions.count
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
