//
//  GamesPage.swift
//  ZoneMaze
//
//  Created by Ali AI on 12/30/23.
//

import Foundation
import SwiftUI

struct GamesPage: View {
    @Binding var theme: String
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Games")
                    .padding()
                    .font(.system(size: 27))
                    .bold()
                List {
                    NavigationLink("Box Clicker", destination: BoxClicker()) 
                        .padding(5)
                    NavigationLink("Meditation", destination: Meditation())
                        .padding(5)
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}
