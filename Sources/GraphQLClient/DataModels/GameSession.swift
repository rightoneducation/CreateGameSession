//
//  GameSession.swift
//  
//
//  Created by Mani Ramezan on 5/17/22.
//

import Foundation

public typealias GameSesionID = UUID
public typealias TimeDuration = Int

public struct GameSession: Codable {
    public enum State: String, Codable {
        case choosingTrickAnswer = "CHOOSING_TRICK_ANSWER"
        case finished = "FINISHED"
        case initialIntro = "INITIAL_INTRO"
        case notStarted = "NOT_STARTED"
        case reviewingResult = "REVIEWING_RESULT"
        case voting = "VOTING"
    }

    public var id: UUID
    public var gameId: GameID
    public var startTime: Date?
    public var phaseOneTime: TimeDuration
    public var phaseTwoTime: TimeDuration
    public var teams: [Team]?
    public var currentQuestionId: Int?
    public var currentState: State
    public var gameCode: Int
    public var questions: [Question]?
    public var updatedAt: Date
    public var createdAt: Date
}
