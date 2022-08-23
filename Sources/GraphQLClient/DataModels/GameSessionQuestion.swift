//
//  GameSessionQuestion.swift
//  
//
//  Created by Mani Ramezan on 8/18/22.
//

import Foundation

public struct GameSessionQuestion: Codable {
    public var id: QuestionID
    public var answer: String
    public var cluster: String?
    public var domain: String?
    public var grade: String?
    public var instructions: String?
    public var imageUrl: String?
    public var standard: String?
    public var text: String?
    public var wrongAnswers: String?
    public var order: Int

    init(from question: Question, order: Int) {
        self.id = question.id
        self.answer = question.answer
        self.cluster = question.cluster
        self.domain = question.domain
        self.grade = question.grade
        self.instructions = question.instructions
        self.imageUrl = question.imageUrl
        self.standard = question.standard
        self.text = question.text
        self.wrongAnswers = question.wrongAnswers
        self.order = order
    }
}
