//
//  Game.swift
//  
//
//  Created by Mani Ramezan on 5/2/22.
//

import Foundation

public typealias GameID = Int

public struct Game: Codable {
    public var id: GameID
    public var title: String?
    public var description: String?
    public var cluster: String?
    public var domain: String?
    public var grade: String?
    public var standard: String?
    public var phaseOneTime: Int?
    public var phaseTwoTime: Int?
    public var imageUrl: String?
    public var questions: [Question]
    public var updatedAt: Date
    public var createdAt: Date
}
