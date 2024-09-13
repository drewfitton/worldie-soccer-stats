//
//  StandingsHeaderView.swift
//  PremierLeagueTeams
//
//  Created by drewf on 9/7/24.
//

import SwiftUI

struct StandingsHeaderView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var headerColor: Color {
        colorScheme == .dark ? Color(hex: "#171719") : Color(hex: "#DDDDDD")
    }
    var body: some View {
        HStack {
            HStack {
                Text("#").font(.system(size: 15)).fontWeight(.bold).frame(minWidth: 10, alignment: .leading)
                Text("Club")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .frame(alignment: .leading)
            }
            .frame(minWidth: 125, alignment: .leading)
            
            HStack{
                Text("W")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .frame(width: 20, alignment: .center)
                Text("D")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    
                    .frame(width: 20, alignment: .center)
                Text("L")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .frame(width: 20, alignment: .center)
                Text("+/-")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .frame(width: 45, alignment: .center)
                Text("GD")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .frame(width: 20, alignment: .center)
                Text("P")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .frame(width: 20, alignment: .center)
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

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255
        )
    }
}

#Preview {
    StandingsHeaderView()
}
