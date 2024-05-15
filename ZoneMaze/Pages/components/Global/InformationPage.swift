//
//  InformationPage.swift
//  ZoneMaze
//
//  Created by Ali AI on 2/24/24.
//

import Foundation
import SwiftUI

struct InformationPage: View {
    @Binding var title: String
    @Binding var description: String
    @Binding var isPresented: Bool
    @AppStorage("theme") var theme = "orange"
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .center) {
                Image("Icon")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
            }
            .padding(.bottom)
            VStack(alignment: .center, spacing: 5) {
                Text(title)
                    .font(.system(size: 35))
                    .bold()
                    .multilineTextAlignment(.center)
                Text(description)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
            }
            Spacer()
            Button(action: {
                isPresented = false
            }, label: {
                Text("Close")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color[theme])
                    .foregroundStyle(.white)
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
        .presentationDetents([.medium, .large])
    } 
}
