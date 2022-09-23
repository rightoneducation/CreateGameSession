//
//  FetchGameOperation.swift
//  
//
//  Created by Mani Ramezan on 5/15/22.
//

import Foundation

struct FetchGameOperation: GQLOperationProtocol {
    typealias Response = Game

    private static let gameIDVariable = "id"

    private let gameID: GameID

    init(id: GameID) {
        gameID = id
    }

    // MARK: - GQLGameOperation

    var variables: [String: Int] {
        [Self.gameIDVariable: gameID]
    }
}

// MARK: - GQLGameOperation Query
extension FetchGameOperation {
    var query: String {
"""
query game($\(Self.gameIDVariable): Int!) {
  getGame(id: $\(Self.gameIDVariable)) {
    id
    cluster
    createdAt
    description
    domain
    grade
    imageUrl
    phaseOneTime
    phaseTwoTime
    standard
    title
    updatedAt
    questions {
      id
      choices
      cluster
      domain
      grade
      instructions
      imageUrl
      standard
      text
      updatedAt
    }
  }
}
"""
    }
}
