//
//  SetupScreen.swift
//  ZoneMaze
//
//  Created by Ali AI on 7/21/24.
//

import Foundation
import SwiftUI

struct SetupScreen: View {
    @State var step = 1
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("theme") var theme = "orange"
    var body: some View {
        VStack {
            NavigationHeaderComponent(name: .constant("ZoneMaze | Setup"), noBack: .constant(false))
            VStack(alignment: .center, spacing: 0) {
                VStack {
                    if (step == 1) {
                        Text("Create your Account")
                            .font(.system(size: 27))
                            .bold()
                    } else if (step == 2) {
                        Text("Select your Theme")
                            .font(.system(size: 27))
                            .bold()
                    }
                }
                HStack {
                    ForEach(1...3, id: \.self) { i in
                        if (i == step) {
                            Circle()
                                .frame(width: 5, height: 5)
                                .foregroundStyle(Color.black.opacity(0.2))
                                .background(Color[theme])
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .frame(width: 5, height: 5)
                                .foregroundStyle(Color.black.opacity(0.2))
                                .background(Color.black.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                }
                .padding()
            }
            .padding(.top)
            if (step == 1) {
                StepOne()
            } else if (step == 2) {
                StepTwo() 
            }
            Spacer()
            Button(action: {
                step += 1
                if step >= 3 {
                    isLoggedIn = true
                }
            }, label: {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color[theme])
                    .foregroundStyle(.white)
                    .bold()
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
            })
            .padding(.bottom, 20)
            .padding(.leading)
            .padding(.leading)
            .padding(.trailing)
            .padding(.trailing)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SetupScreen()
}
