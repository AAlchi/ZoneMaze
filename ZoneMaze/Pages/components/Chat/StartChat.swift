//
//  StartChat.swift
//  ZoneMaze
//
//  Created by Ali AI on 5/8/24.
//

import Foundation
import SwiftUI

struct StartChat: View {
    @AppStorage("theme") var theme = "orange"
    @Binding var isChosen: Bool
    @Binding var type: String
    @State var navigate = false
    @AppStorage("isNavbarShowing") var isNavbarShowing = true
 
    var body: some View {
            VStack {
                VStack {
                    Text("What type of chat?")
                        .bold()
                        .font(.system(size: 27))
                    Text("All conversations are anonymous")
                        .foregroundStyle(Color.gray)
                }
                .padding(.top)
                .padding(.bottom)
                ScrollView {
                    VStack(spacing: 5) {
                        Button(action: {
                            type = "Chat with a person"
                            isChosen = true
                        }, label: {
                            Text("Chat with a person")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color[theme])
                                .foregroundStyle(.white)
                                .bold()
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        })
                        .padding(.leading)
                        .padding(.trailing)
                        Button(action: {
                            type = "Chat with AI"
                        }, label: {
                            Text("Chat with AI")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color[theme])
                                .foregroundStyle(.white)
                                .bold()
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        })
                        .padding(.leading)
                        .padding(.trailing)
                        .opacity(0.5)
                        Button(action: {
                            type = "Chat with a professional"
                        }, label: {
                            Text("Chat with a professional")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color[theme])
                                .foregroundStyle(.white)
                                .bold()
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        })
                        .padding(.leading)
                        .padding(.trailing)
                        .opacity(0.5)
                    }
                }
            }
            .padding(.top)
            .padding(.bottom)
            Spacer()
    }
}
