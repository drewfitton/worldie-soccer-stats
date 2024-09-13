//
//  MatchesView.swift
//  PremierLeagueTeams
//
//  Created by drewf on 9/4/24.
//

import SwiftUI

struct MatchesView: View {
    
    @State var competitions: [Competition] = Competition.defaultCompetitions
    @State private var sectionVisibility: [Int: Bool] = [:]
    @State var selectedMatch: Match?
    @State var selectedDate = Date()
    @State var vm = MatchesObservable()
    
    @Environment(\.colorScheme) var colorScheme
    var headerColor: Color {
        colorScheme == .dark ? Color(hex: "#171719") : Color(hex: "#DDDDDD")
    }
    var backgroundColor: Color {
        colorScheme == .dark ? Color.black : Color(hex: "#f2f2f7")
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack (spacing: 0){
                    ForEach(competitions) { competition in
                        if competition.matches != nil {
                            Section {
                                if sectionVisibility[competition.id, default: true] {
                                    LeagueMatchesTable(matches: competition.matches)
                                }
                            } header: {
                                HStack {
                                    Text(competition.name).font(.headline)
                                    Spacer()
                                    Image(systemName: sectionVisibility[competition.id, default: true] ? "chevron.down" : "chevron.right")
                                }
                                .padding(.horizontal, 5.0)
                                .frame(height: 40.0)
                                .background(
                                    sectionVisibility[competition.id, default: true]
                                    ? AnyView(TopRoundedRectangle(cornerRadius: 10).fill(headerColor))
                                    : AnyView(RoundedRectangle(cornerRadius: 10).fill(headerColor))
                                )
                                .onTapGesture {
                                    sectionVisibility[competition.id, default: true].toggle()
                                }
                                .padding(.top, 10)
                            }
                            .padding(.horizontal, 5.0)
                            //.padding(.top, 10)
                        }
                    }
                }
                .padding(.horizontal, 15.0)
            }
            .toolbar {
                HStack {
                    Image("Worldie")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 70, alignment: .leading)
                    
                    Spacer()
                    DatePicker(
                        "Matchday",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(DefaultDatePickerStyle())
                }
            }
            .background(backgroundColor)
            .overlay {
                switch vm.fetchPhase {
                case .fetching: ProgressView()
                case .success(let matches) where matches.isEmpty:
                    Text("").font(.headline)
                case .failure(let error):
                    Text(error.localizedDescription).font(.headline)
                default: EmptyView()
                }
            }
            .task(id: selectedDate) {
                for i in competitions.indices.prefix(6) {
                    await vm.fetchMatches(competition: competitions[i], date: selectedDate)
                    competitions[i].matches = vm.matches ?? []
                }
            }
        }
    }
}

#Preview {
    MatchesView()
}

