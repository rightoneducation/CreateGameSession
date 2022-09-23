//
//  CreateQuestionOperation.swift
//  
//
//  Created by Mani Ramezan on 5/26/22.
//

import Foundation

struct CreateQuestionOperation: GQLOperationProtocol {
    typealias Response = GameSessionQuestion

    private static let idVariable = "id"
    private static let choicesVariable = "choices"
    private static let clusterStateVariable = "cluster"
    private static let domainCodeVariable = "domain"
    private static let gradeOneTimeVariable = "grade"
    private static let instructionsTwoTimeVariable = "instructions"
    private static let imageUrlAdvancedVariable = "imageUrl"
    private static let standardVariable = "standard"
    private static let textVariable = "text"
    private static let gameSessionIdVariable = "gameSessionId"
    private static let orderVariable = "order"

    let input: CreateQuestionInput

    init(input: CreateQuestionInput) {
        self.input = input
    }
    
    var variables: [String: CodableWrap] {
        let choicesValue: CodableWrap
        if
            let choicesData = try? JSONEncoder().encode(input.choices),
            let choicesStr = String(data: choicesData, encoding: .utf8) {
            choicesValue = .init(choicesStr)
        } else {
            choicesValue = .null
        }
        return [
            Self.idVariable: .init(input.id),
            Self.choicesVariable: choicesValue,
            Self.clusterStateVariable: .init(input.cluster),
            Self.domainCodeVariable: .init(input.domain),
            Self.gradeOneTimeVariable: .init(input.grade),
            Self.instructionsTwoTimeVariable: .init(input.instructions),
            Self.imageUrlAdvancedVariable: .init(input.imageUrl),
            Self.standardVariable: .init(input.standard),
            Self.textVariable: .init(input.text),
            Self.gameSessionIdVariable: .init(input.gameSessionId),
            Self.orderVariable: .init(input.order)
        ]
    }
}

extension CreateQuestionOperation {
    var query: String {
"""
mutation createQuestion(
    $\(Self.idVariable): Int!,
    $\(Self.choicesVariable): AWSJSON!,
    $\(Self.clusterStateVariable): String,
    $\(Self.domainCodeVariable): String,
    $\(Self.gradeOneTimeVariable): String,
    $\(Self.instructionsTwoTimeVariable): AWSJSON,
    $\(Self.imageUrlAdvancedVariable): String,
    $\(Self.standardVariable): String,
    $\(Self.textVariable): String!,
    $\(Self.gameSessionIdVariable): ID!,
    $\(Self.orderVariable): Int!,
) {
    createQuestion(
        input: {
            \(Self.idVariable): $\(Self.idVariable)
            \(Self.choicesVariable): $\(Self.choicesVariable)
            \(Self.clusterStateVariable): $\(Self.clusterStateVariable)
            \(Self.domainCodeVariable): $\(Self.domainCodeVariable)
            \(Self.gradeOneTimeVariable): $\(Self.gradeOneTimeVariable)
            \(Self.instructionsTwoTimeVariable): $\(Self.instructionsTwoTimeVariable)
            \(Self.imageUrlAdvancedVariable): $\(Self.imageUrlAdvancedVariable)
            \(Self.standardVariable): $\(Self.standardVariable)
            \(Self.textVariable): $\(Self.textVariable)
            \(Self.gameSessionIdVariable): $\(Self.gameSessionIdVariable)
            \(Self.orderVariable): $\(Self.orderVariable)
        }
    ) {
        \(Self.idVariable)
        \(Self.choicesVariable)
        \(Self.clusterStateVariable)
        \(Self.domainCodeVariable)
        \(Self.gradeOneTimeVariable)
        \(Self.instructionsTwoTimeVariable)
        \(Self.imageUrlAdvancedVariable)
        \(Self.standardVariable)
        \(Self.textVariable)
        \(Self.gameSessionIdVariable)
        \(Self.orderVariable)
    }
}
"""
    }
}
