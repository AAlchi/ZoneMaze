//
//  GoodDayComponent.swift
//  ZoneMaze
//
//  Created by Ali AI on 4/29/24.
//

import Foundation
import SwiftUI

struct GoodDayComponent: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Welcome! Having a good day?")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.gray)
                    .bold()
                Spacer()
//                NavigationLink("See All", destination: GoodTimesPage(theme: $theme, add: $isFalse, goodDays: $goodDays))
            }.padding()
            HStack {
//                Spacer()
//                NavigationLink {
//                    GoodTimesPage(theme: $theme, add: $isFalse, goodDays: $goodDays)
//                } label: {
//                    Text("Yes!")
//                        .frame(width: geo.size.width * 0.4, height: 45)
//                        .background(Color[theme])
//                        .foregroundStyle(.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 3.0))
//                }
                Spacer()
//                Button {
//                    isAlert = true
//                } label: {
//                    Text("Not Yet!")
//                        .frame(width: geo.size.width * 0.4, height: 45)
//                        .background(.black.opacity(0.1))
//                        .foregroundStyle(Color[theme])
//                        .clipShape(RoundedRectangle(cornerRadius: 3.0))
//                }
                Spacer()
            }
        }
        .padding()
//        .alert("Sorry to hear. It's not too late though!", isPresented: $isAlert) {
//            Button("Ok", role: .cancel) { }
//        }
    }
}
 
