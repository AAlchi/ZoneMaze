//
//  NavigationLinkComponent.swift
//  ZoneMaze
//
//  Created by Ali AI on 5/4/24.
//

import Foundation
import SwiftUI

struct NavigationHeaderComponent: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var name: String
    @Binding var noBack: Bool
    @State var isPresented = false
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Text(name)
                }
                if noBack {
                    HStack {
                        HStack {
                            Text("End Chat")
                        }
                        .onTapGesture {
                            isPresented = true
                        }
                        .bold()
                        Spacer()
                    }
                } else {
                    HStack {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .bold()
                        Spacer()
                    }
                }
            }
            .padding(.top)
            .padding(.leading)
            .padding(.trailing)
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text("Are you sure you want to end the chat?"),
                    primaryButton: .default(
                        Text("Cancel"),
                        action: cancel
                        ),
                    secondaryButton: .destructive(
                        Text("End Chat"),
                        action: endChat
                    )
                )
            }
        }
    }
    func cancel() {
        isPresented = false
    }
    func endChat() {
        presentationMode.wrappedValue.dismiss()
    }
}
 
