//
//  Goal.swift
//  PremierLeagueTeams
//
//  Created by drewf on 8/23/24.
//

import Foundation

public struct Goal: Decodable {
    
    public let minute: Int
    public let type: String
    public let team: Team
    public let scorer: Player
    public let assist: Player?
    public let score: Score
}
