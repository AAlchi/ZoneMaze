//
//  Settings.swift
//  ZoneMaze
//
//  Created by Ali AI on 4/27/24.
//

import Foundation
import SwiftUI

struct SettingsComponent: View {
    @Binding var theme: String
    @Binding var theTime: Bool

    @State var colors = ["blue", "orange", "red", "yellow"]
    @State var settingsName = "Settings"
    @State var search = ""
    
    // For Input
    @State var name = "Search"
    @State var text = ""
    
    @State var noBack = false
    var body: some View {
        VStack {
            NavigationHeaderComponent(name: $settingsName, noBack: $noBack)
            Input(name: $name, text: $text, includeMag: .constant(true), includeSend: .constant(false), isSend: .constant(false))
            VStack {
                List {
                    Section("Change Theme") {
                        ForEach(colors, id: \.self) { color in
                            Button(color) {
                                theme = color
                                theTime = true
                            }
                            .foregroundStyle(Color[color])
                        }
                    }
                    Section("Danger Zone") {
                        Text("Delete Account")
                    }
                }
            }
            .background(Color.black.opacity(0.1))
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
    }
}
 
