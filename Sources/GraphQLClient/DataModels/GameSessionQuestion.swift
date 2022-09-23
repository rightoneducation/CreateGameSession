//
//  GameSessionQuestion.swift
//  
//
//  Created by Mani Ramezan on 8/18/22.
//

import Foundation

public typealias QuestionID = Int

public struct GameSessionQuestion: Codable {
    public var id: QuestionID
    public var choices: [Question.Choice]
    public var cluster: String?
    public var domain: String?
    public var grade: String?
    public var instructions: String?
    public var imageUrl: String?
    public var standard: String?
    public var text: String?
    public var order: Int

    init(from question: Question, order: Int) {
        self.id = question.id
        self.choices = question.choices
        self.cluster = question.cluster
        self.domain = question.domain
        self.grade = question.grade
        self.instructions = question.instructions
        self.imageUrl = question.imageUrl
        self.standard = question.standard
        self.text = question.text
        self.order = order
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(QuestionID.self, forKey: .id)
        let unparsedChoices = try container.decode(String.self, forKey: .choices)
        self.choices = try Question.Choice.parseAppsyncResponse(unparsedChoices).shuffled()
        self.cluster = try container.decodeIfPresent(String.self, forKey: .cluster)
        self.domain = try container.decodeIfPresent(String.self, forKey: .domain)
        self.grade = try container.decodeIfPresent(String.self, forKey: .grade)
        self.instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        self.standard = try container.decodeIfPresent(String.self, forKey: .standard)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.order = try container.decode(Int.self, forKey: .order)
    }
}
