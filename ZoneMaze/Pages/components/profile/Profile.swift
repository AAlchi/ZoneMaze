//
//  Profile.swift
//  ZoneMaze
//
//  Created by Ali AI on 5/13/24.
//

import Foundation
import SwiftUI

struct Profile: View {
    @AppStorage("theme") var theme = "orange"
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                NavigationHeaderComponent(name: .constant("Profile"), noBack: .constant(false))
                Text("Your Profile")
                    .bold()
                    .font(.title)
                    .padding(.top)
                    .padding(.leading)
                List {
//                    Section("Main Info") {
//                        HStack {
//                            Text("Name")
//                                .bold()
//                            Spacer()
//                            Text("Test")
//                        }
//                    }
                    Text("Looks like you are in guest mode. Try signing in to add your info.")
                    HStack {
                        Text("Sign In/Sign Up")
                            .foregroundStyle(Color[theme])
                    }
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
    }
}

