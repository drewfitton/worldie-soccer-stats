//
//  SwiftUIView.swift
//  PremierLeagueTeams
//
//  Created by drewf on 9/4/24.
//

import SwiftUI

struct LeagueMatchesTable: View {
    
    var matches: [Match]?
    @Environment(\.colorScheme) var colorScheme
    var bodyColor: Color {
        colorScheme == .dark ? Color(hex: "#1c1c1f") : Color.white
    }
    
    var body: some View {
        VStack {
            ForEach(matches ?? []) {match in
                HStack (spacing: 0) {
                    HStack {
                        Text(match.homeTeam?.shortName ?? "")
                            .font(.system(size: 15))
                        TeamCrest(crestURL: match.homeTeam?.crest, size:
                                    "medium")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    VStack {
                        Text(displayMatchTimeOrStatus(match))
                            .frame(alignment: .top)
                            .font(.system(size: 10))
                        HStack(spacing: 2) {
                            Text(match.score.fullTime?.homeString ?? "")
                            Text("-")
                            Text(match.score.fullTime?.awayString ?? "")
                        }
                        .frame(alignment: .center)
                        Spacer()
                    }
                    .fixedSize()
                    .frame(maxWidth: 50)
                    HStack {
                        TeamCrest(crestURL: match.awayTeam?.crest, size:
                                    "medium")
                        Text(match.awayTeam?.shortName ?? "")
                            .font(.system(size: 15))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 5.0)
        .background(
            BottomRoundedRectangle(cornerRadius: 10)
                .fill(bodyColor)
        )
    }
    
    private func displayMatchTimeOrStatus(_ match: Match) -> String {
        if match.status == "FINISHED" {
            return "FT"
        } else {
            // Format the utcDate to show only the time
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short // Set to show only time
            return dateFormatter.string(from: match.utcDate)
        }
    }
}

#Preview {
    LeagueMatchesTable()
}

