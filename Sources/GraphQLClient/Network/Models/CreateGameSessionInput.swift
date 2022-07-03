//
//  CreateGameSessionInput.swift
//  
//
//  Created by Mani Ramezan on 5/23/22.
//

import Foundation

struct CreateGameSessionInput {
    static let defaultPhaseOneTime = 300
    static let defaultPhaseTwoTime = 300

//    var id: UUID
    var currentState: GameSession.State
    var gameCode: Int
    var phaseOneTime: TimeDuration
    var phaseTwoTime: TimeDuration
    var imageUrl: String?
    var description: String?
    var title: String?
    var isAdvancedMode: Bool
    var grade: String?
    var gameId: GameID

    init(for game: Game, with gameCode: Int, isAdvancedMode: Bool) {
        currentState = .notStarted
        grade = game.grade
        title = game.title
        phaseOneTime = game.phaseOneTime ?? Self.defaultPhaseOneTime
        phaseTwoTime = game.phaseTwoTime ?? Self.defaultPhaseTwoTime
        imageUrl = game.imageUrl
        description = game.description
        gameId = game.id
        self.isAdvancedMode = isAdvancedMode
        self.gameCode = gameCode
    }

//    init(
//        id: UUID,
//        gameCode: Int,
//        gameSessionGameId: Int,
//        phaseOneTime: Int = Self.defaultPhaseOneTime,
//        phaseTwoTime: Int = Self.defaultPhaseTwoTime,
//        imageUrl: String? = nil,
//        description: String? = nil,
//        title: String? = nil
//    ) {
//        self.id = id
//        self.currentState = .notStarted
//        self.gameCode = gameCode
//        self.gameSessionGameId = gameSessionGameId
//        self.phaseOneTime = phaseOneTime
//        self.phaseTwoTime = phaseTwoTime
//        self.imageUrl = imageUrl
//        self.description = description
//        self.title = title
//    }
}
