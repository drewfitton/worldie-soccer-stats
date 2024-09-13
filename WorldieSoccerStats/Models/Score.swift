//
//  Score.swift
//  PremierLeagueTeams
//
//  Created by drewf on 8/23/24.
//

import Foundation

public struct IntervalScore: Decodable {
    public var home: Int?
    public var away: Int?
    public var homeString: String? {
        return home != nil ? String(home!) : ""
    }
    public var awayString: String? {
        return away != nil ? String(away!) : ""
    }
}

public struct Score: Decodable {
    
    public var winner: String?
    public var duration: String
    
    public var fullTime: IntervalScore?
    public var halfTime: IntervalScore?
}
