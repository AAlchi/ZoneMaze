//
//  PhysicalHealthQuiz.swift
//  ZoneMaze
//
//  Created by Ali AI on 2/24/24.
//

import Foundation
import SwiftUI

struct PhysicalHealthQuiz: View {
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
                HealthSummary(topic: $title)
            } label: {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.orange)
                    .foregroundStyle(.white)
                    .bold()
                    .clipShape(RoundedRectangle(cornerRadius: 3.0))
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isPresented, content: {
            VStack {
                InformationPage(title: $title, description: $description, isPresented: $isPresented)
            }
        })
    }
}
