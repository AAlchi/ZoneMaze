//
//  Loading.swift
//  My App
//
//  Created by Ali Alchikh Ibrahim on 9/11/23.
//

import SwiftUI

struct LoadingComponent: View {
    @Binding var theme: String
    @Binding var time: Bool
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                Image("Loading")
                    .resizable()
                    .frame(width: 150, height: 150)
            }
            Spacer()
        }
        .onAppear {
            time = true
            Timer.scheduledTimer(withTimeInterval: 2,  repeats: false) { timer in
                withAnimation {
                    time = false
                }
            }
        }
    }
}
