//
//  NotificationBanner.swift
//  ZoneMaze
//
//  Created by Ali AI on 2/17/24.
//

import Foundation
import SwiftUI

struct NotificationBannerComponent: View {
    @ObservedObject var notifications = TheObservedObject()
    var body: some View {
            GeometryReader { geo in
                VStack {
                    HStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Schedule")
                                        .font(.system(size: 24))
                                        .bold()
                                    Text(notifications.notifyText)
                                }
                                Spacer()
                            }
                        }
                        .frame(width: geo.size.width * 0.8)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                        Spacer()
                    }
                    
                    Spacer()
                }
                .padding(.top)
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 3,  repeats: false) { timer in
                        withAnimation {
                            notifications.notify = false
                        }
                    }
                }
        }
    }
}

#Preview {
    NotificationBannerComponent()
}
