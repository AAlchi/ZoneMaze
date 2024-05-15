//
//  Shortcuts.swift
//  ZoneMaze
//
//  Created by Ali AI on 12/28/23.
//

import Foundation
import SwiftUI

struct QuotesComponent: View {
    @Binding var theme: String
    
    @State var quotes = [
        "Mountains are not flat. Sometimes hard work is needed to reach the top." : "ZoneMaze",
        "No one is going to make you give up except yourself. Don't give up!" : "ZoneMaze",
        "Dreams stay dreams until you make them a reality." : "ZoneMaze",
        "No one will stop you if you work in silence." : "ZoneMaze",
        "Take it easy. Success doesn't come overnight." : "ZoneMaze"
    ]
    @State private var clickedItem: Int? = nil

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("Quotes")
                    .bold()
                    .font(.system(size: 23))
                Spacer()
            }
            .padding(.top)
            .padding(.leading)
            .padding(.trailing)
            VStack {
                
                HStack {
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(quotes.sorted(by: >), id: \.key){ key, quote in
                                VStack {
                                    Text("\"\(key)\"")
                                        .font(.system(size: 30))
                                        .bold()
                                        .padding(.top)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                        .overlay(Color.white)
                                    VStack {
                                        Divider()
                                        HStack {
                                            Spacer()
                                            Text("- \(quote)")
                                                .bold()
                                                .padding(.top)
                                        }
                                        
                                    }
                                }.frame(width: 300, height: 300)
                                    .padding()
                                    .background(Color[theme].gradient)
                                    .foregroundColor(.white)
                                    .cornerRadius(5.0, antialiased: true)
                            }
                        }
                    }
                } 
            }
            .padding(.leading)
            .padding(.trailing)
        }
        
    }
    
}
