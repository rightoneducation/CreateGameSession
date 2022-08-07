//
//  TeamAnswer.swift
//  
//
//  Created by Mani Ramezan on 5/17/22.
//

import Foundation

public typealias TeamAnswerID = String

public struct TeamAnswer: Codable {
    public var id: TeamAnswerID
    public var isChosen: Bool = false
    public var text: String
}
