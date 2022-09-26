//
//  CreateQuestionInput.swift
//  
//
//  Created by Mani Ramezan on 5/26/22.
//

import Foundation

struct CreateQuestionInput {
    var gameSessionId: GameSesionID
    var id: QuestionID
    var choices: [Question.Choice]
    var cluster: String?
    var domain: String?
    var grade: String?
    var instructions: String?
    var imageUrl: String?
    var standard: String?
    var text: String?
    var order: Int

    init(gameSessionId: GameSesionID, question: Question, order: Int) {
        self.gameSessionId = gameSessionId
        self.id = question.id
        self.choices = question.choices
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
    }
}
