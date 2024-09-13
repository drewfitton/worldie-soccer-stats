import SwiftUI

struct StandingsTableView: View {
    
    let competition: Competition
    @Bindable var vm = StandingsTableObservable()
    
    var body: some View {
        VStack(spacing: 0) { // Ensure no spacing between elements
            Text(competition.name + " Standings")
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
                        ForEach(vm.standings ?? []) { club in
                            HStack {
                                Text(club.positionText)
                                    .font(.system(size: 13))
                                    .fontWeight(.semibold)
                                    .frame(minWidth: 10, alignment: .leading)
                                
                                HStack {
                                    TeamCrest(crestURL: club.team.crest, size: "small")
                                    
                                    Text(club.team.shortName ?? "")
                                        .font(.system(size: 13))
                                }
                                
                                HStack {
                                    Text(club.wonText)
                                        .font(.system(size: 13))
                                        .frame(width: 20, alignment: .center)
                                    
                                    Text(club.drawText)
                                        .font(.system(size: 13))
                                        .frame(width: 20, alignment: .center)
                                    
                                    Text(club.lostText)
                                        .font(.system(size: 13))
                                        .frame(width: 20, alignment: .center)
                                    
                                    Text("\(club.goalsForText)-\(club.goalsAgainstText)")
                                        .font(.system(size: 13))
                                        .frame(width: 45, alignment: .center)
                                    
                                    Text(club.goalDifferenceText)
                                        .font(.system(size: 13))
                                        .frame(width: 20, alignment: .center)
                                    
                                    Text(club.pointsText)
                                        .font(.system(size: 13))
                                        .frame(minWidth: 20, alignment: .center)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.horizontal, 5)
                        }
                    } header: {
                        StandingsHeaderView()
                    }
                }
            }
        }
        .overlay {
            switch vm.fetchPhase {
            case .fetching: ProgressView()
            case .failure(let error): Text(error.localizedDescription).font(.headline)
            default: EmptyView()
            }
        }
        .task(id: vm.selectedFilter.id) {
            await vm.fetchStandings(competition: competition)
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Picker("Filter Options", selection: $vm.selectedFilter) {
                    ForEach(vm.filterOptions, id: \.self) { season in
                        Text(" \(season.text) ")
                    }
                }.pickerStyle(.segmented)
            }
        }
        .navigationTitle("") // Explicitly set an empty title
        .navigationBarTitleDisplayMode(.inline)
    }
}
