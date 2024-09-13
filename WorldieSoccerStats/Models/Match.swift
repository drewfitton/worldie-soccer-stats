//
//  Match.swift
//  PremierLeagueTeams
//
//  Created by drewf on 8/23/24.
//

import Foundation

public struct Match: Identifiable, Decodable, Hashable {
    
    
    public let area: Area
    public let competition: Competition?
    
    public let id: Int
    public var utcDate: Date
    public var status: String
    public var matchday: Int
    public var stage: String?
    public var group: String?
    
    public let homeTeam: Team?
    public let awayTeam: Team?
    
    public let score: Score
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func ==(lhs: Match, rhs: Match) -> Bool {
        return lhs.id == rhs.id
    }
    
}

public struct MatchesResponse: Decodable {
    
    public var matches: [Match]?
    
}
