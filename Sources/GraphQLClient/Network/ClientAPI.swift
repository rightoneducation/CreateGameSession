//
//  ClientAPI.swift
//  
//
//  Created by Mani Ramezan on 5/3/22.
//

import Foundation
import Grallistrix
import AsyncAlgorithms
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

//GraphQL endpoint: https://ndd5d3mff5f7ni3cxc4rm6rkky.appsync-api.us-east-1.amazonaws.com/graphql
//GraphQL API KEY: da2-jtckofyk6vcuzeqg5h647xegta

public class ClientAPI {
    public enum NetworkError: Error {
        case invalidResponse(String)
        case invalidRequest
        case serverError(Int)
        case failed([String])
    }

    struct GraphQLEndpoint {
        let url: URL
        let apiKey: String
    }

    private let urlSession: URLSession

    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    public func fetchGameAsync(id: GameID) async throws -> Game {
        let operation = FetchGameOperation(id: id)

        return try await performOperation(operation, to: .web)
    }

    public func fetchGameSessionBy(gameCode: Int) async throws -> [GameSession] {
        let operation = FetchGameSessionByCodeOperation(gameCode: gameCode)
        let result = try await performOperation(operation, to: .mobile)
        return result.first?.value ?? []
    }

    public func createGameSession(for game: Game, with gameCode: Int, isAdvanceMode: Bool) async throws -> GameSession {
        let input = CreateGameSessionInput(for: game, with: gameCode, isAdvancedMode: isAdvanceMode)
        let operation = CreateGameSessionOperation(input: input)
        var gameSession = try await performOperation(operation, to: .mobile)
        let questions = try await withThrowingTaskGroup(of: GameSessionQuestion.self) { [weak self] group -> [GameSessionQuestion] in
            guard let self = self else {
                throw NetworkError.failed(["Opps... failed accessing self"])
            }
            for (idx, question) in game.questions.enumerated() {
                let questionOperation = CreateQuestionOperation(input: .init(gameSessionId: gameSession.id, question: question, order: idx))
                group.addTask {
                    let question = try await self.performOperation(questionOperation, to: .mobile)
                    return GameSessionQuestion(from: question, order: idx)
                }
            }
            return try await group.reduce(into: []) { result, question in
                result.append(question)
            }
        }
        gameSession.questions = GameSessionQuestions(items: questions)
        return gameSession
    }

    // MARK: - Private helper methods

    private func performOperation<Operation: GQLOperationProtocol>(_ operation: Operation, to endpoint: GraphQLEndpoint) async throws -> Operation.Response {
        var urlRequest = createRequest(for: endpoint)

        guard let body = try? JSONEncoder().encode(operation) else {
            throw NetworkError.invalidRequest
        }
        urlRequest.httpBody = body
        let (data, response) = try await urlSession.asyncData(for: urlRequest)

        guard let urlResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse(String(data: data, encoding: .utf8) ?? "Oops, something went wrong casting response.")
        }

        guard 200..<400 ~= urlResponse.statusCode else {
            throw NetworkError.serverError(urlResponse.statusCode)
        }

        let operationResponse: GQLResponse<Operation.Response>
        do {
            operationResponse = try JSONDecoder().withISO8091DateDecoding().decode(GQLResponse<Operation.Response>.self, from: data)
        } catch {
            throw NetworkError.invalidResponse(error.localizedDescription)
        }

        guard let result = operationResponse.result else {
            throw NetworkError.failed(operationResponse.errorMessages)
        }

        return result
    }

    private func createRequest(for endpoint: GraphQLEndpoint) -> URLRequest {
        var urlRequest = URLRequest(url: endpoint.url)

        urlRequest.addValue(endpoint.apiKey, forHTTPHeaderField: "x-api-key")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("*/*", forHTTPHeaderField: "Accept")
        urlRequest.addValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        urlRequest.httpMethod = "POST"

        return urlRequest
    }
}

extension JSONDecoder {
    fileprivate func withISO8091DateDecoding() -> Self {
        dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let stringVal = try container.decode(String.self)
            guard let date = DateFormatter.awsISO8601Decode.date(from: stringVal) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(stringVal)")
            }

            return date
        })
        return self
    }
}

/// An extension that provides async support for fetching a URL
///
/// Needed because the Linux version of Swift does not support async URLSession yet.
public extension URLSession {

    /// A reimplementation of `URLSession.shared.data(from: url)` required for Linux
    ///
    /// - Parameter urlRequest: The request  for which to load data.
    /// - Returns: Data and response.
    ///
    /// - Usage:
    ///
    ///     let (data, response) = try await URLSession.shared.asyncData(from: url)
    func asyncData(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    continuation.resume(throwing: ClientAPI.NetworkError.invalidResponse("Failed to receive HTTPURLResponse"))
                    return
                }
                guard let data = data else {
                    continuation.resume(throwing: ClientAPI.NetworkError.invalidResponse("No data returned by server"))
                    return
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }
}
