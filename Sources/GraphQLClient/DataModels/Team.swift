//
//  Team.swift
//  
//
//  Created by Mani Ramezan on 5/17/22.
//

import Foundation

public typealias TeamID = String

public struct Team: Codable {
    public var id: TeamID
    public var name: String
    public var question: Question
    public var trickiestAnswerIDs: [TeamAnswerID] = []
    public var teamMembers: [TeamMember] = []
    public var score: Int!
    public var selectedAvatarIndex: Int!
}
