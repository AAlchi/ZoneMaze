//
//  BoxClicker.swift
//  ZoneMaze
//
//  Created by Ali AI on 2/24/24.
//

import Foundation
import SwiftUI

struct BoxClicker: View {
    @AppStorage("wins") var wins = 0
    @State var random = [1, 2, 3, 4]
    @State var randomNum = 1
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack {
                    Text("Wins: \(wins)")
                        .bold()
                    Spacer()
                    Button("Reset") {
                        wins = 0
                    }
                }
                .padding()
                HStack {
                    if randomNum == 1 {
                        VStack {
                            Text("Click")
                                .font(.system(size: 30))
                                .foregroundStyle(Color.orange)
                                .bold()
                        }
                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.4)
                        .background(Color.white)
                        .border(Color.orange)
                        .onTapGesture {
                            wins += 1
                            if let ra = random.randomElement() {
                                randomNum = ra
                            }
                        }
                    } else {
                        VStack {
                            
                        }
                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.4)
                        .background(Color.orange)
                        .onTapGesture {
                            if let ra = random.randomElement() {
                                randomNum = ra
                            }
                        }
                    }
                    if randomNum == 2 {
                        VStack {
                            Text("Click")
                                .font(.system(size: 30))
                                .foregroundStyle(Color.orange)
                                .bold()
                        }
                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.4)
                        .background(Color.white)
                        .border(Color.orange)
                        .onTapGesture {
                            wins += 1
                            if let ra = random.randomElement() {
                                randomNum = ra
                            }
                        }
                    } else {
                        VStack {
                            
                        }
                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.4)
                        .background(Color.orange)
                        .onTapGesture {
                            if let ra = random.randomElement() {
                                randomNum = ra
                            }
                        }
                    }
                }
                HStack {
                    if randomNum == 3 {
                        VStack {
                            Text("Click")
                                .font(.system(size: 30))
                                .foregroundStyle(Color.orange)
                                .bold()
                        }
                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.4)
                        .background(Color.white)
                        .border(Color.orange)
                        .onTapGesture {
                            wins += 1
                            if let ra = random.randomElement() {
                                randomNum = ra
                            }
                        }
                    } else {
                        VStack {
                            
                        }
                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.4)
                        .background(Color.orange)
                        .onTapGesture {
                            if let ra = random.randomElement() {
                                randomNum = ra
                            }
                        }
                    }
                    if randomNum == 4 {
                        VStack {
                            Text("Click")
                                .font(.system(size: 30))
                                .foregroundStyle(Color.orange)
                                .bold()
                        }
                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.4)
                        .background(Color.white)
                        .border(Color.orange)
                        .onTapGesture {
                            wins += 1
                            if let ra = random.randomElement() {
                                randomNum = ra
                            }
                        }
                    } else {
                        VStack {
                            
                        }
                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.4)
                        .background(Color.orange)
                        .onTapGesture {
                            if let ra = random.randomElement() {
                                randomNum = ra
                            }
                        }
                    }
                }
                Spacer()
            }
            .onAppear() {
                if let ra = random.randomElement() {
                    randomNum = ra
                }
            }
        }
    }
}

#Preview {
    BoxClicker()
}
