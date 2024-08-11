//
//  StepThree.swift
//  ZoneMaze
//
//  Created by Ali AI on 7/21/24.
//

import Foundation
import SwiftUI

struct StepTwo: View {
    @AppStorage("theme") var theme = "orange"
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @State var list = ["Orange", "Red", "Yellow", "Blue", "Pink", "Purple", "Green", "Cyan", "Brown", "Indigo", "Mint", "Teal", "Gray", "Black"]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ]) {
                ForEach(list, id: \.self) { i in
                    if (i.lowercased() == theme) {
                        Rectangle()
                            .fill(Color[i.lowercased()].shadow(.inner(color: .black, radius: 5)))
                            .frame(height: 150)
                            .overlay {
                                VStack {
                                    Text(i)
                                        .foregroundStyle(Color.white)
                                }
                                .padding()
                            }
                            .onTapGesture {
                                theme = i.lowercased()
                            }
                            .border(Color.black.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    } else {
                        Rectangle()
                            .fill(Color[i.lowercased()])
                            .frame(height: 150)
                            .overlay {
                                VStack {
                                    Text(i)
                                        .foregroundStyle(Color.white)
                                    if theme == i.lowercased() {
                                        Image(systemName: "checkmark.square.fill")
                                            .padding()
                                            .background(.black.opacity(0.2))
                                            .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                    }
                                }
                                .padding()
                            }
                            .onTapGesture {
                                theme = i.lowercased()
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    }
                }
            }
            .padding()
        } 
    }
} 
