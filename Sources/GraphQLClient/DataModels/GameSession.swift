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
        case notStarted = "NOT_STARTED"
        case teamsJoining = "TEAMS_JOINING"
        case chooseCorrectAnswer = "CHOOSE_CORRECT_ANSWER"
        case phase1Results = "PHASE_1_RESULTS"
        case chooseTrickiestAnswer = "CHOOSE_TRICKIEST_ANSWER"
        case phase2Results = "PHASE_2_RESULTS"
        case finalResults = "FINAL_RESULTS"
        case finished = "FINISHED"
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
    public var currentTimer: Int?
    public var updatedAt: Date
    public var createdAt: Date
}
