//
//  FetchGameSessionByCodeOperation.swift
//  
//
//  Created by Mani Ramezan on 5/17/22.
//

import Foundation

struct FetchGameSessionByCodeOperation: GQLOperationProtocol {
    typealias Response = [String: [GameSession]]

    private static let gameCodeVariable = "gameCode"

    private let gameCode: Int

    init(gameCode: Int) {
        precondition(1000...9999 ~= gameCode)
        self.gameCode = gameCode
    }

    // MARK: - GQLGameOperation

    var variables: [String: Int] {
        [Self.gameCodeVariable: gameCode]
    }
}

extension FetchGameSessionByCodeOperation {
    var query: String {
"""
query gameSessionByCode($\(Self.gameCodeVariable): Int!) {
    gameSessionByCode(\(Self.gameCodeVariable): $\(Self.gameCodeVariable)) {
        items {
            id
            currentState
            gameCode
        }
    }
}
"""
    }
}
