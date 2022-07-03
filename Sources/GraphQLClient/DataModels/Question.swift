//
//  Question.swift
//  
//
//  Created by Mani Ramezan on 5/3/22.
//

import Foundation

public typealias QuestionID = Int

public struct Question: Codable {
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
}
