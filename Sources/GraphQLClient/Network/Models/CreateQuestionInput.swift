//
//  CreateQuestionInput.swift
//  
//
//  Created by Mani Ramezan on 5/26/22.
//

import Foundation

struct CreateQuestionInput {
    var gameSessionId: GameSessionID
    var id: QuestionID
    var choices: [Question.Choice]
    var answerSettings: String?
    var cluster: String?
    var domain: String?
    var grade: String?
    var instructions: String?
    var imageUrl: String?
    var standard: String?
    var text: String?
    var order: Int
    var isConfidenceEnabled: Bool
    var isShortAnswerEnabled: Bool
    var isHintEnabled: Bool

    init(gameSessionId: GameSessionID, question: Question, order: Int) {
        self.gameSessionId = gameSessionId
        self.id = question.id
        self.choices = question.choices
        if let answerSettings = question.answerSettings,
            let encodedString = try? JSONEncoder().encode(answerSettings),
            let jsonString = String(data: encodedString, encoding: .utf8) {
             self.answerSettings = jsonString
         } else {
             self.answerSettings = nil
         }
        self.cluster = question.cluster
        self.domain = question.domain
        self.grade = question.grade
        if let encodedInstructions = try? JSONEncoder().encode(question.instructions ?? []) {
            self.instructions = String(data: encodedInstructions, encoding: .utf8)
        } else {
            self.instructions = ""
        }
        self.imageUrl = question.imageUrl
        self.standard = question.standard
        self.text = question.text
        self.order = order
        self.isConfidenceEnabled = false
        self.isShortAnswerEnabled = false
        self.isHintEnabled = true
    }
}
