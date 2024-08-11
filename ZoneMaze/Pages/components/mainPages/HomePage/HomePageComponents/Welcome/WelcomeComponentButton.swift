//
//  WelcomeComponentButton.swift
//  ZoneMaze
//
//  Created by Ali AI on 5/14/24.
//

import Foundation
import SwiftUI

struct WelcomeComponentButton: View {
    @Binding var name: String
    @Binding var image: String
    
    var body: some View {
        Rectangle()
            .fill(Color.black.opacity(0.2))
            .opacity(0.4)
            .frame(height: 35)
            .overlay {
                HStack(spacing: 5) {
                    Image(systemName: image)
                        .resizable()
                        .frame(width: 13, height: 13)
                        .clipShape(Circle())
                        .foregroundStyle(Color.gray)
                    Text(name)
                        .foregroundStyle(Color.gray)
                    
                    Spacer()
                }
                .padding()
            }
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
} 
