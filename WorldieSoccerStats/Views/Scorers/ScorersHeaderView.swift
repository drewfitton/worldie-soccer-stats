//
//  StandingsHeaderView.swift
//  PremierLeagueTeams
//
//  Created by drewf on 9/7/24.
//

import SwiftUI

struct ScorersHeaderView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var headerColor: Color {
        colorScheme == .dark ? Color(hex: "#171719") : Color(hex: "#DDDDDD")
    }
    var body: some View {
        HStack {
            HStack {
                Text("#").font(.system(size: 15)).fontWeight(.bold).frame(minWidth: 10, alignment: .leading)
                Text("Player")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .frame(alignment: .leading)
            }
            .frame(minWidth: 125, alignment: .leading)
            
            HStack{
                Text("Goals")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .frame(width: 50, alignment: .center)
                Text("Assists")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    
                    .frame(width: 50, alignment: .center)
                Text("MP")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .frame(width: 50, alignment: .center)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, 5.0)
        .frame(maxWidth: .infinity, minHeight: 40, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(headerColor)
        )
    }

}

#Preview {
    StandingsHeaderView()
}
