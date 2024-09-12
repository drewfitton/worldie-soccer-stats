//
//  StandingsTabItemView.swift
//  PremierLeagueTeams
//
//  Created by drewf on 8/22/24.
//

import SwiftUI

struct StandingsTabItemView: View {
    
    @State var selectedCompetition: Competition?
    @Environment(\.colorScheme) var colorScheme

    var backgroundColor: Color {
        colorScheme == .dark ? Color.black : Color(hex: "#f2f2f7")
    }
    
    var body: some View {
        NavigationSplitView {
            VStack(spacing: 0 ) {
                Text("Select League")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                //.padding(.bottom, 10)
                    .frame(maxWidth: .infinity)
                    .lineLimit(1)
                List(Competition.defaultCompetitions, id: \.self, selection: $selectedCompetition) {
                    Text($0.name)
                }
            }
            .background(backgroundColor)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("Worldie")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 70, alignment: .leading)
                }
            }
        } detail: {
            if let selectedCompetition {
                StandingsTableView(competition: selectedCompetition)
                    .id(selectedCompetition)
            } else {
                Text("Select a competition")
            }
        }
    }
}

#Preview {
    StandingsTabItemView()
}

