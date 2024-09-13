//
//  TopScorersTableView.swift
//  PremierLeagueTeams
//
//  Created by drewf on 8/22/24.
//

import SwiftUI

struct TopScorersTableView: View {
    
    let competition: Competition
    @Bindable var vm = TopScorersTableObservable()
    
    var body: some View {
        VStack(spacing: 0) { // Ensure no spacing between elements
            Text(competition.name + " Scorers")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity)
                .lineLimit(1)
            
            ScrollView {
                LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) { // Ensure no spacing between rows
                    Section {
                        ForEach(vm.scorers ?? []) { scorer in
                            HStack {
                                Text(scorer.posText)
                                    .font(.system(size: 13))
                                    .fontWeight(.semibold)
                                    .frame(minWidth: 10, alignment: .leading)
                                
                                HStack {
                                    TeamCrest(crestURL: scorer.team.crest, size: "small")
                                    
                                    Text(scorer.player.name)
                                        .font(.system(size: 13))
                                }
                                
                                HStack {
                                    Text(scorer.goalsText)
                                        .font(.system(size: 13))
                                        .frame(width: 50, alignment: .center)
                                    
                                    Text(scorer.assistsText)
                                        .font(.system(size: 13))
                                        .frame(width: 50, alignment: .center)
                                    
                                    Text(scorer.playedMatchesText)
                                        .font(.system(size: 13))
                                        .frame(width: 50, alignment: .center)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.horizontal, 5)
                        }
                    } header: {
                        ScorersHeaderView()
                    }
                }
            }
            .foregroundStyle(.primary)
            .overlay {
                switch vm.fetchPhase {
                case .fetching: ProgressView()
                case .success(let scorers) where scorers.isEmpty:
                    Text("Scorers not available").font(.headline)
                case .failure(let error):
                    Text(error.localizedDescription).font(.headline)
                default: EmptyView()
                }
            }
            .task(id: vm.selectedFilter.id) {
                await vm.fetchTopScorers(competition: competition)
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Picker("Filter Options", selection: $vm.selectedFilter) {
                        ForEach(vm.filterOptions, id: \.self) { season in
                            Text(" \(season.text) ")
                        }
                    }
                    .padding(.horizontal, 10)
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("") // Explicitly set an empty title
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        TopScorersTableView(competition: .defaultCompetitions[0])
    }
}
