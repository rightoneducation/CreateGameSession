//
//  QuestionSharedAttr.swift
//  
//
//  Created by Mani Ramezan on 8/18/22.
//

import Foundation

public typealias QuestionID = Int

protocol QuestionSharedAttr {
    var id: QuestionID { get }
    var answer: String { get }
    var cluster: String? { get }
    var domain: String? { get }
    var grade: String? { get }
    var instructions: String? { get }
    var imageUrl: String? { get }
    var standard: String? { get }
    var text: String? { get }
    var wrongAnswers: String? { get }
}
