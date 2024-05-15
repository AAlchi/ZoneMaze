//
//  AreYouSure.swift
//  ZoneMaze
//
//  Created by Ali AI on 1/4/24.
//

import Foundation
import SwiftUI

struct ConfirmationScreen: View {
    @Binding var isLoggedIn: Bool
    @Binding var theme: String
    @State var step = 1
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    HStack {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .bold()
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                        Spacer()
                    }
                    VStack {
                        HStack(spacing: 1) {
                            Image("Icon")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(Circle())
                            Text("oneMaze")
                                .font(.system(size: 17))
                                .foregroundStyle(Color.black.opacity(0.7))
                                .multilineTextAlignment(.center)
                                .bold()
                        }
                    }
                }
                .padding()
                
                if step == 1 {
                    Text("Local or cloud data?")
                        .font(.system(size: 28))
                        .multilineTextAlignment(.center)
                        .bold()
                    HStack {
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundStyle(Color[theme])
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundStyle(Color.black.opacity(0.2))
                    }
                    StepOne(step: $step)
                } else if step == 2 {
                    Text("Choose your theme")
                        .font(.system(size: 28))
                        .multilineTextAlignment(.center)
                        .bold()
                    HStack {
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundStyle(Color.black.opacity(0.2))
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundStyle(Color[theme])
                    }
                    StepTwo()
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}
    
