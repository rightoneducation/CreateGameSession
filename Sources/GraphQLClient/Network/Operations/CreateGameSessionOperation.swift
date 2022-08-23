//
//  CreateGameSessionOperation.swift
//  
//
//  Created by Mani Ramezan on 5/22/22.
//

import Foundation

struct CreateGameSessionOperation: GQLOperationProtocol {

    typealias Response = GameSession

    
    private static let idVariable = "id"
    private static let gameIdVariable = "gameId"
    private static let currentStateVariable = "currentState"
    private static let gameCodeVariable = "gameCode"
    private static let phaseOneTimeVariable = "phaseOneTime"
    private static let phaseTwoTimeVariable = "phaseTwoTime"
    private static let isAdvancedModeVariable = "isAdvancedMode"
    private static let imageUrlVariable = "imageUrl"
    private static let descriptionVariable = "description"
    private static let titleVariable = "title"
    private static let createdAtVariable = "createdAt"
    private static let updatedAtVariable = "updatedAt"
    private static let currentTimer = "currentTimer"

    private let input: CreateGameSessionInput

    init(input: CreateGameSessionInput) {
        self.input = input
    }

    // MARK: - GQLGameOperation

    var variables: [String: CodableWrap] {
        [
            Self.gameIdVariable: .init(input.gameId),
            Self.currentStateVariable: .init(input.currentState),
            Self.gameCodeVariable: .init(input.gameCode),
            Self.phaseOneTimeVariable: .init(input.phaseOneTime),
            Self.phaseTwoTimeVariable: .init(input.phaseTwoTime),
            Self.isAdvancedModeVariable: .init(input.isAdvancedMode),
            Self.imageUrlVariable: .init(input.imageUrl ?? ""),
            Self.descriptionVariable: .init(input.description ?? ""),
            Self.titleVariable: .init(input.title ?? ""),
            Self.currentTimer: .null
        ]
    }
}

extension CreateGameSessionOperation {
    var query: String {
"""
mutation createGameSession(
    $\(Self.gameIdVariable): Int!,
    $\(Self.currentStateVariable): GameSessionState!,
    $\(Self.gameCodeVariable): Int!,
    $\(Self.phaseOneTimeVariable): Int!,
    $\(Self.phaseTwoTimeVariable): Int!,
    $\(Self.isAdvancedModeVariable): Boolean!,
    $\(Self.imageUrlVariable): String,
    $\(Self.descriptionVariable): String,
    $\(Self.titleVariable): String,
    $\(Self.currentTimer): Int,
) {
    createGameSession(
        input: {
            \(Self.gameIdVariable): $\(Self.gameIdVariable)
            \(Self.currentStateVariable): $\(Self.currentStateVariable)
            \(Self.gameCodeVariable): $\(Self.gameCodeVariable)
            \(Self.phaseOneTimeVariable): $\(Self.phaseOneTimeVariable)
            \(Self.phaseTwoTimeVariable): $\(Self.phaseTwoTimeVariable)
            \(Self.imageUrlVariable): $\(Self.imageUrlVariable)
            \(Self.descriptionVariable): $\(Self.descriptionVariable)
            \(Self.titleVariable): $\(Self.titleVariable)
            \(Self.isAdvancedModeVariable): $\(Self.isAdvancedModeVariable)
            \(Self.currentTimer): $\(Self.currentTimer)
        }
    ) {
        \(Self.idVariable)
        \(Self.gameIdVariable)
        \(Self.currentStateVariable)
        \(Self.gameCodeVariable)
        \(Self.phaseOneTimeVariable)
        \(Self.phaseTwoTimeVariable)
        \(Self.imageUrlVariable)
        \(Self.descriptionVariable)
        \(Self.titleVariable)
        \(Self.currentTimer)
        \(Self.isAdvancedModeVariable)
        \(Self.createdAtVariable)
        \(Self.updatedAtVariable)
    }
}
"""
    }
}
