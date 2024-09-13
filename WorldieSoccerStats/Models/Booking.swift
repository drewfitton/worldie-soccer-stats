//
//  Booking.swift
//  PremierLeagueTeams
//
//  Created by drewf on 8/23/24.
//

import Foundation

public struct Booking: Decodable{
    public let minute: Int?
    public let team: Team?
    public let player: Player?
    public let card: String?
}
