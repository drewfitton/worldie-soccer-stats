//
//  WorldieSoccerStatsApp.swift
//  WorldieSoccerStats
//
//  Created by drewf on 8/22/24.
//

import SwiftUI

let apiKey = "2a59e2ed31cb4c499f4483d5188a1d2d"

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
