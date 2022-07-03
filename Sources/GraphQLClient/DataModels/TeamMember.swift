//
//  TeamMember.swift
//  
//
//  Created by Mani Ramezan on 5/17/22.
//

import Foundation

public typealias TeamMemberID = UUID

public struct TeamMember: Codable {
    public var id: TeamMemberID
    public var team: Team
    public var isFacilitator: Bool = false
    public var memberAnswers: [TeamAnswer] = []
    public var deviceID: UUID
}
