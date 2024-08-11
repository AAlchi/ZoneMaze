//
//  StepOne.swift
//  ZoneMaze
//
//  Created by Ali AI on 7/21/24.
//

import Foundation
import SwiftUI

struct StepOne: View {
    //user info
    @State var username: String = ""
    @State var email: String = ""
    @State var key: String = ""
    var body: some View {
        VStack {
            HStack {
                Text("Username")
                Text("*")
                    .foregroundStyle(.red)
                Spacer()
            }
            TextField("", text: $username)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(.black.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .padding(.horizontal)
        .padding(.horizontal)
        .padding(.vertical, 5)
        
        VStack {
            HStack {
                Text("Email")
                Text("*")
                    .foregroundStyle(.red)
                Spacer()
            }
            TextField("", text: $email)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(.black.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .padding(.horizontal)
        .padding(.horizontal)
        .padding(.vertical, 5)
        
        VStack {
            HStack {
                Text("Key/Password")
                Text("")
                    .foregroundStyle(.red)
                Spacer()
            }
            SecureField("", text: $key)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(.black.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .padding(.horizontal)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview {
    StepOne()
}
