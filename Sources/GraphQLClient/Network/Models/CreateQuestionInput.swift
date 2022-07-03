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
    var answer: String
    var cluster: String?
    var domain: String?
    var grade: String?
    var instructions: String?
    var imageUrl: String?
    var standard: String?
    var text: String?
    var wrongAnswers: String?

    init(gameSessionId: GameSesionID, question: Question) {
        self.gameSessionId = gameSessionId
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
    }
}
