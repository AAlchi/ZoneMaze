//
//  Input.swift
//  ZoneMaze
//
//  Created by Ali AI on 5/8/24.
//

import Foundation
import SwiftUI
import UIKit
 
struct Input: View {
    // Input
    @State var messages: [MessageData] = []
        
    func addMessage() {
        isSend = true
    }
    
    @Binding var name: String
    @Binding var text: String
    
    @Binding var includeMag: Bool
    @Binding var includeSend: Bool
    @Binding var isSend: Bool
    @State var disabled = true
     
    @AppStorage("theme") var theme = "orange"
    
    var body: some View {
        LazyVStack {
            ZStack {
                if (includeMag) {
                    TextField("Name", text: $text)
                        .padding(.leading)
                        .padding(.leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.trailing)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .background(Color.black.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding(.leading)
                            .foregroundStyle(Color.gray)
                        Spacer()
                    }
                } else {
                    TextField(name, text: $text)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .background(Color.black.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                        .onChange(of: text) { old, new in
                            disabled = new.isEmpty
                        }
                }
                if includeSend {
                    HStack {
                        Spacer()
                        if disabled {
                            VStack {
                                Image(systemName: "arrowshape.right.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color[theme])
                                    .opacity(0.5)
                            }
                            .padding()
                        } else {
                            Button(action: {
                                addMessage()
                            }, label: {
                                Image(systemName: "arrowshape.right.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color[theme])
                            })
                            .padding()
                        }
                    }
                }
            }
        }
        .padding(.top)
        .padding(.leading)
        .padding(.trailing)
    }
}
