//
//  CreateQuestionOperation.swift
//  
//
//  Created by Mani Ramezan on 5/26/22.
//

import Foundation

struct CreateQuestionOperation: GQLOperationProtocol {
    typealias Response = Question

    private static let idVariable = "id"
    private static let answerVariable = "answer"
    private static let clusterStateVariable = "cluster"
    private static let domainCodeVariable = "domain"
    private static let gradeOneTimeVariable = "grade"
    private static let instructionsTwoTimeVariable = "instructions"
    private static let imageUrlAdvancedVariable = "imageUrl"
    private static let standardVariable = "standard"
    private static let textVariable = "text"
    private static let wrongAnswersVariable = "wrongAnswers"
    private static let gameSessionIdVariable = "gameSessionId"

    let input: CreateQuestionInput

    init(input: CreateQuestionInput) {
        self.input = input
    }
    
    var variables: [String: CodableWrap] {
        [
            "id": .init(input.id),
            "answer": .init(input.answer),
            "cluster": .init(input.cluster),
            "domain": .init(input.domain),
            "grade": .init(input.grade),
            "instructions": .init(input.instructions),
            "imageUrl": .init(input.imageUrl),
            "standard": .init(input.standard),
            "text": .init(input.text),
            "wrongAnswers": .init(input.wrongAnswers),
            "gameSessionId": .init(input.gameSessionId),
        ]
    }
}

extension CreateQuestionOperation {
    var query: String {
"""
mutation createQuestion(
    $\(Self.idVariable): Int!,
    $\(Self.answerVariable): String!,
    $\(Self.clusterStateVariable): String,
    $\(Self.domainCodeVariable): String,
    $\(Self.gradeOneTimeVariable): String,
    $\(Self.instructionsTwoTimeVariable): AWSJSON,
    $\(Self.imageUrlAdvancedVariable): String,
    $\(Self.standardVariable): String,
    $\(Self.textVariable): String!,
    $\(Self.wrongAnswersVariable): AWSJSON,
    $\(Self.gameSessionIdVariable): ID!,
) {
    createQuestion(
        input: {
            \(Self.idVariable): $\(Self.idVariable)
            \(Self.answerVariable): $\(Self.answerVariable)
            \(Self.clusterStateVariable): $\(Self.clusterStateVariable)
            \(Self.domainCodeVariable): $\(Self.domainCodeVariable)
            \(Self.gradeOneTimeVariable): $\(Self.gradeOneTimeVariable)
            \(Self.instructionsTwoTimeVariable): $\(Self.instructionsTwoTimeVariable)
            \(Self.imageUrlAdvancedVariable): $\(Self.imageUrlAdvancedVariable)
            \(Self.standardVariable): $\(Self.standardVariable)
            \(Self.textVariable): $\(Self.textVariable)
            \(Self.wrongAnswersVariable): $\(Self.wrongAnswersVariable)
            \(Self.gameSessionIdVariable): $\(Self.gameSessionIdVariable)
        }
    ) {
        \(Self.idVariable)
        \(Self.answerVariable)
        \(Self.clusterStateVariable)
        \(Self.domainCodeVariable)
        \(Self.gradeOneTimeVariable)
        \(Self.instructionsTwoTimeVariable)
        \(Self.imageUrlAdvancedVariable)
        \(Self.standardVariable)
        \(Self.textVariable)
        \(Self.wrongAnswersVariable)
        \(Self.gameSessionIdVariable)
    }
}
"""
    }
}
