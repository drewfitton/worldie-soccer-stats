//
//  WorldieSoccerStatsApp.swift
//  WorldieSoccerStats
//
//  Created by drewf on 8/22/24.
//

import SwiftUI

let apiKey = "YOUR_KEY_HERE"

@main
struct WorldieSoccerStatsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                MatchesView()
                    .tabItem{ Label("Matches", systemImage: "figure.soccer")}
                
                StandingsTabItemView()
                    .tabItem { Label("Standings", systemImage: "table.fill") }
                
                TopScorersTabItemView()
                    .tabItem { Label("Top Scorers", systemImage: "soccerball")}
            }
        }
    }
}
