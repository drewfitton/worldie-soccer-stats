//
//  Penalty.swift
//  PremierLeagueTeams
//
//  Created by drewf on 8/23/24.
//

import Foundation

public struct Penalty: Decodable{
    public let player: Player
    public let team: Team
    public let scored: Bool
}
