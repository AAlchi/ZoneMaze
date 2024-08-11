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
            VStack {
                List {
                    Section("General") {
                        Text("Change theme")
                        Text("Change account key")
                        Text("Log Out")
                    }
                    Section("User Info") {
                        HStack {
                            Text("Username")
                                .bold()
                            Spacer()
                            Text("AAlchi")
                        }
                        HStack {
                            Text("Email")
                                .bold()
                            Spacer()
                            Text("aalchikhibrahim@gmail.com")
                        }
                        HStack {
                            Text("Account Created")
                                .bold()
                            Spacer()
                            Text("3/12/2422")
                        }
                        HStack {
                            Text("Last Update")
                                .bold()
                            Spacer()
                            Text("3/13/2422")
                        }
                    }
                    Section("Account Data") {
                        Text("Export account data")
                        Text("See app permissions")
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
 
