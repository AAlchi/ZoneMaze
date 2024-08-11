//
//  PhysicalHealthQuiz.swift
//  ZoneMaze
//
//  Created by Ali AI on 2/24/24.
//

import Foundation
import SwiftUI

struct PhysicalHealthQuiz: View {
    @Binding var theme: String

    @Environment(\.dismiss) var dismiss
    @State var isPresented = true
    @State var title = "Physical Health Quiz"
    @State var description = "Physical health impacts many things and has an impact on your social and mental health."
    @State var isOn = true
    @ObservedObject var questions = TheObservedObject()
    @State var question: [PhysicalHealth] = []

    var body: some View {
        VStack {
            HStack {
                Text("Physical Health")
                    .font(.system(size: 27))
                    .bold()
                Spacer()
            }.padding(.bottom, 5)
            ScrollView {
                ForEach(questions.physicalHealth, id: \.id) { i in
                    HStack {
                        Text(i.question)
                        Spacer()
                        Image(systemName: i.checked ? "checkmark.square" : "square")
                            .onTapGesture {
                                if i.checked {
                                    if let index = questions.physicalHealth.firstIndex(where: { $0.id == i.id }) {
                                        questions.physicalHealth[index].checked = false
                                    }
                                } else {
                                    if let index = questions.physicalHealth.firstIndex(where: { $0.id == i.id }) {
                                        questions.physicalHealth[index].checked = true
                                    }
                                }
                            }
                    }
                    .padding(.top)
                    .padding(.bottom)
                    Divider()
                }
            }
            NavigationLink {
                HealthSummary(theme: $theme, topic: $title)
            } label: {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color[theme])
                    .foregroundStyle(.white)
                    .bold()
                    .clipShape(RoundedRectangle(cornerRadius: 3.0))
            } 
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isPresented, content: {
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
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Go Back")
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
                .presentationDetents([.medium, .large])
        })
    }
}
