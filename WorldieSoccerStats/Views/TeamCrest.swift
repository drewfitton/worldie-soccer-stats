//
//  TeamCrest.swift
//  PremierLeagueTeams
//
//  Created by drewf on 8/26/24.
//

import SwiftUI

struct TeamCrest: View {
    
    let crestURL: String?
    let size: String

    var body: some View {
        Group {
            if let crestURL = crestURL, crestURL.hasSuffix("svg") {
                if size == "small" {
                    SVGImage(url: URL(string: crestURL)!, size: .init(width: 20, height: 20))
                        .frame(width: 20, height: 20)
                        .cornerRadius(10)
                } else if size == "large" {
                    SVGImage(url: URL(string: crestURL)!, size: .init(width: 50, height: 50))
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                } else {
                    SVGImage(url: URL(string: crestURL)!, size: .init(width: 30, height: 30))
                        .frame(width: 30, height: 30)
                        .cornerRadius(15)
                }
            } else {
                AsyncImage(url: URL(string: crestURL ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                    default:
                        Circle().foregroundStyle(Color.gray.opacity(0.5))
                    }
                }
                .frame(width: 30, height: 30)
            }
        }
    }
}

#Preview {
    TeamCrest(crestURL: "", size: "large")
}
