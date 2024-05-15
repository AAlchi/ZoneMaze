//
//  ChatComponent.swift
//  ZoneMaze
//
//  Created by Ali AI on 5/2/24.
//

import Foundation
import SwiftUI

struct ChatComponent: View { 
    @State var chat = "Chat"
    @AppStorage("theme") var theme = "orange"
    @State var isChosen = false
    @State var type = ""
    @State var noBack = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    func back() {
        presentationMode.wrappedValue.dismiss()
    }
    var body: some View {
        VStack {
            if !isChosen {
                VStack {
                    NavigationHeaderComponent(name: $chat, noBack: .constant(false))
                }
            } else {
                VStack {
                    NavigationHeaderComponent(name: $chat, noBack: .constant(true))
                }
            }
            Spacer()
            if !isChosen {
                StartChat(isChosen: $isChosen, type: $type)
            } else {
                ChatUI()
            }
        }
        .navigationBarBackButtonHidden() 
        .toolbar(.hidden, for: .tabBar)
    }
}
