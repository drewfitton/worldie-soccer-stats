//
//  MatchesObservable.swift
//  PremierLeagueTeams
//
//  Created by drewf on 8/26/24.
//

import Foundation
import Observation

@Observable

class MatchesObservable {
    
    let client = FootballDataClient(apiKey: apiKey)
    var fetchPhase = Fetch<[Match]>.initial
    
    var matches: [Match]? { fetchPhase.value }
    
    var selectedFilter = FilterOption.latest
    var filterOptions: [FilterOption] = {
        var date = Calendar.current.date(byAdding: .year, value: -4, to: Date())!
        var options = [FilterOption]()
        for i in 0..<3 {
            if let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: date) {
                options.append(.year(Calendar.current.component(.year, from: nextYear)))
                date = nextYear
            }
        }
        options.append(.latest)
        return options
    }()
    
    func fetchMatches(competition: Competition, date: Date) async {
        fetchPhase = .fetching
        do {
            var matches = try await client.fetchMatches(competitionId: competition.id, filterOption: selectedFilter)
            if Task.isCancelled { return }
            
            let calendar = Calendar.current
            let targets = calendar.dateComponents([.year, .month, .day], from: date)
            
            let filteredMatches = matches.filter { match in
                let matchComponents = calendar.dateComponents([.year, .month, .day], from: match.utcDate)
                return targets == matchComponents
            }
            
            matches = filteredMatches.sorted {$0.utcDate < $1.utcDate}
            
            fetchPhase = .success(matches)
        } catch {
            if Task.isCancelled { return }
            print("L")
            print(error)
            fetchPhase = .failure(error)
        }
    }
    
}

