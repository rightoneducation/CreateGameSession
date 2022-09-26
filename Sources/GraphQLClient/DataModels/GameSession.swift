//
//  GameSession.swift
//  
//
//  Created by Mani Ramezan on 5/17/22.
//

import Foundation

public typealias GameSesionID = String
public typealias TimeDuration = Int

public struct GameSession: Codable {
    public enum State: String, Codable {
        case notStarted = "NOT_STARTED"
        case teamsJoining = "TEAMS_JOINING"
        case chooseCorrectAnswer = "CHOOSE_CORRECT_ANSWER"
        case phase1Discuss = "PHASE_1_DISCUSS"
        case phase1Results = "PHASE_1_RESULTS"
        case phase2Start = "PHASE_2_START"
        case chooseTrickiestAnswer = "CHOOSE_TRICKIEST_ANSWER"
        case phase2Discuss = "PHASE_2_DISCUSS"
        case phase2Results = "PHASE_2_RESULTS"
        case finalResults = "FINAL_RESULTS"
        case finished = "FINISHED"
    }

    public var id: GameSesionID
    public var gameId: GameID
    public var startTime: Date?
    public var phaseOneTime: TimeDuration
    public var phaseTwoTime: TimeDuration
    public var teams: [Team]?
    public var currentQuestionIndex: Int?
    public var currentState: State
    public var gameCode: Int
    public var questions: GameSessionQuestions?
    public var currentTimer: Int?
    public var isAdvancedMode: Bool
    public var updatedAt: Date
    public var createdAt: Date
}
