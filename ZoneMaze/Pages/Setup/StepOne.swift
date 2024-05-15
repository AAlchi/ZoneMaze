//
//  Step1.swift
//  ZoneMaze
//
//  Created by Ali AI on 5/1/24.
//

import Foundation
import SwiftUI

struct StepOne: View {
    @Binding var step: Int
    @State var isPresented = false
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("loadingScreen") var theTime = false
    @AppStorage("theme") var theme = "orange"
    // Input
    @State var username = ""
    @State var password = ""
    @State var email = ""
    @State var signup = false
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(systemName: "cloud").font(.system(size: 28))
                            .frame(width: 60)
                        Text("Cloud allows you to sign into other devices")
                            .font(.system(size: 18))
                    }
                    HStack {
                        Image(systemName: "candybarphone").font(.system(size: 28))
                            .frame(width: 60)
                        Text("Local only lets you keep your data on your device")
                            .font(.system(size: 18))
                    }
                }
                .padding(.top)
            }
            .padding(.leading)
            .padding(.trailing)
            
            Spacer()
            VStack {
                Button(action: {
                    isPresented = true
                }, label: {
                    Text("Set up an account")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color[theme])
                        .foregroundStyle(.white)
                        .bold()
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                })
                Button(action: {
                    step = 2
                }, label: {
                    Text("Continue on device storage")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white)
                        .foregroundStyle(Color[theme])
                        .bold()
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                })
            }
            .padding(.top)
            .padding(.leading)
            .padding(.trailing)
            .padding(.top)
            .padding(.leading)
            .padding(.trailing)
            .popover(isPresented: $isPresented) {
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading, spacing: 5) {
                            if (signup) {
                                Text("Sign Up")
                                    .font(.system(size: 35))
                                    .bold()
                                    .multilineTextAlignment(.center)
                            } else {
                                Text("Sign In")
                                    .font(.system(size: 35))
                                    .bold()
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding(.bottom)
                        VStack {
                            TextField("Username", text: $username)
                                .padding(.leading)
                                .padding(.trailing)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 3.0))
                            if (signup) {
                                TextField("Email", text: $email)
                                    .padding(.leading)
                                    .padding(.trailing)
                                    .padding(.top, 10)
                                    .padding(.bottom, 10)
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(RoundedRectangle(cornerRadius: 3.0))
                            }
                            SecureField("Password", text: $password)
                                .padding(.leading)
                                .padding(.trailing)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        }
                        Spacer()
                        Button(action: {
                            isPresented = false
                            step = 2
                        }, label: {
                            if (signup) {
                                Text("Sign Up")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color[theme])
                                    .foregroundStyle(.white)
                                    .bold()
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            } else {
                                Text("Log In")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color[theme])
                                    .foregroundStyle(.white)
                                    .bold()
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            }
                        })
                        Button(action: {
                            signup.toggle()
                        }, label: {
                            if (signup) {
                                Text("Have an account? Sign in")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(.white)
                                    .foregroundStyle(Color[theme])
                                    .bold()
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            } else {
                                Text("No account? Sign up")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(.white)
                                    .foregroundStyle(Color[theme])
                                    .bold()
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            }
                        })
                    }
                    .padding(.top)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)
                    .padding(.leading)
                    .padding(.trailing)
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
}

