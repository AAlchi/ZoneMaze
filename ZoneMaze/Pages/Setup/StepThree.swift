//
//  StepThree.swift
//  ZoneMaze
//
//  Created by Ali AI on 4/28/24.
//

import Foundation
import SwiftUI

struct StepThree: View {
    @Binding var isNew: Bool
    @Binding var theme: String
    @Binding var isLoggedIn: Bool
    @Binding var isNavbarShowing: Bool
    
    @State var username = ""
    @State var password = ""
    @State var readMore = false
    @State var whichImage = "w1"
    @State var whichImageNumber = 0
    
    var body: some View {
        HStack {
            Text("ZoneMaze")
                .font(.system(size: 27))
                .bold()
            Spacer()
            Image(systemName: "xmark.app.fill")
                .onTapGesture {
                    isNew = false
                }
        }
        .padding()
        .padding()
        VStack {
            Spacer()
            VStack {
                VStack {
                    Image("\(whichImage)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                }
                        VStack(alignment: .leading) {
                            VStack(alignment: .center) {
                                if (whichImageNumber == 0) {
                                    Text("Take a break and reflect")
                                        .font(.system(size: 25))
                                        .bold()
                                } else if (whichImageNumber == 1) {
                                    Text("Avoid distractions")
                                        .font(.system(size: 25))
                                        .bold()
                                } else {
                                    Text("Connect with others")
                                        .font(.system(size: 25))
                                        .bold()
                                }
                               
                            }
                        }
                        
                    }
            Spacer()
        }
        HStack {
                if (whichImage != "w1") {
                    Button(action: {
                        if whichImage == "w3" {
                            withAnimation {
                                whichImage = "w2"
                                whichImageNumber = 1
                            }
                        } else if whichImage == "w2" {
                            withAnimation {
                                whichImage = "w1"
                                whichImageNumber = 0
                            }
                        }
                    }, label: {
                        Text("Previous")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.black.opacity(0.1))
                            .foregroundStyle(Color[theme])
                            .bold()
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    })
                    .padding()
                }
                Button(action: {
                    if whichImage == "w1" {
                        withAnimation {
                            whichImage = "w2"
                            whichImageNumber = 1
                        }
                    } else if whichImage == "w2" {
                        withAnimation {
                            whichImage = "w3"
                            whichImageNumber = 2
                        }
                    } else if whichImage == "w3" {
                        isNew = false
                    }
                }, label: {
                    if (whichImage == "work3") {
                        Text("Continue")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color[theme])
                            .foregroundStyle(.white)
                            .bold()
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    } else {
                        Text("Next")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color[theme])
                            .foregroundStyle(.white)
                            .bold()
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    }
                })
                .padding()
            }
    }
}

