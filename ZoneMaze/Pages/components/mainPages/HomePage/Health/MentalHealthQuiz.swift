//
//  PhysicalHealthQuiz.swift
//  ZoneMaze
//
//  Created by Ali AI on 2/24/24.
//

import Foundation
import SwiftUI

struct MentalHealthQuiz: View {
    @State var isPresented = true
    @State var title = "Mental Health Quiz"
    @State var description = "Mental health impacts many things and has an impact on your social and physical health."
    @State var isOn = true
    @ObservedObject var questions = TheObservedObject()
    @State var question: [MentalHealth] = []

    var body: some View {
        VStack {
            HStack {
                Text("Mental Health")
                    .font(.system(size: 27))
                    .bold()
                Spacer()
            }.padding(.bottom, 5)
            ScrollView {
                ForEach(questions.mentalHealth, id: \.id) { i in
                    HStack {
                        Text(i.question)
                        Spacer()
                        Image(systemName: i.checked ? "checkmark.square" : "square")
                            .onTapGesture {
                                if i.checked {
                                    if let index = questions.mentalHealth.firstIndex(where: { $0.id == i.id }) {
                                        questions.mentalHealth[index].checked = false
                                    }
                                } else {
                                    if let index = questions.mentalHealth.firstIndex(where: { $0.id == i.id }) {
                                        questions.mentalHealth[index].checked = true
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
