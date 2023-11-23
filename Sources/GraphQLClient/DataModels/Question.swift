//
//  Question.swift
//  
//
//  Created by Mani Ramezan on 5/3/22.
//

import Foundation

public struct Question: Codable {
    public struct Choice: Codable {
        public var text: String
        public var isAnswer: Bool
        public var reason: String?
    }
    
    public struct AnswerSettings: Codable {
        public var answerType: String
        public var answerPrecision: String
    }
    
    public var id: QuestionID
    public var choices: [Choice]
    public var answerSettings: AnswerSettings?
    public var cluster: String?
    public var domain: String?
    public var grade: String?
    public var instructions: [String]?
    public var imageUrl: String?
    public var standard: String?
    public var text: String?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(QuestionID.self, forKey: .id)
        let unparsedChoices = try container.decode(String.self, forKey: .choices)
        self.choices = try Choice.parseAppsyncResponse(unparsedChoices).shuffled()
        if let unparsedAnswerSettings = try container.decodeIfPresent(String.self, forKey: .answerSettings),
           let answerSettingsData = unparsedAnswerSettings.data(using: .utf8) {
            self.answerSettings = try JSONDecoder().decode(AnswerSettings.self, from: answerSettingsData)
        } else {
            self.answerSettings = nil
        }
        self.cluster = try container.decodeIfPresent(String.self, forKey: .cluster)
        self.domain = try container.decodeIfPresent(String.self, forKey: .domain)
        self.grade = try container.decodeIfPresent(String.self, forKey: .grade)
        if
            let unparsedInstructions = try container.decodeIfPresent(String.self, forKey: .instructions),
            let instructionsData = unparsedInstructions.data(using: .utf8)
        {
            self.instructions = try JSONDecoder().decode([String].self, from: instructionsData)
        } else {
            self.instructions = nil
        }

        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        self.standard = try container.decodeIfPresent(String.self, forKey: .standard)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
    }
}

extension Question.Choice {
    static func parseAppsyncResponse(_ str: String) throws -> [Question.Choice] {
        let choicesUnparsed: String
        if
            let choicesData = str.data(using: .utf8),
            let choicesStr = try? JSONDecoder().decode(String.self, from: choicesData)
        {
            choicesUnparsed = choicesStr
        } else {
            choicesUnparsed = str
        }

        guard
            let choicesStrData = choicesUnparsed.data(using: .utf8),
            let parsedChoices = try? JSONDecoder().decode([Question.Choice].self, from: choicesStrData)
        else {
            throw ClientAPI.NetworkError.failed(["Failed to parse `choices` field"])
        }

        return parsedChoices
    }
}
