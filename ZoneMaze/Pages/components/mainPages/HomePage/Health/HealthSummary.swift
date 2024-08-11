//
//  HealthSummary.swift
//  ZoneMaze
//
//  Created by Ali AI on 2/24/24.
//

import Foundation
import SwiftUI

struct HealthSummary: View {
    @Binding var topic: String
    @State var health = TheObservedObject()
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                Spacer()
                VStack(alignment: .leading) {
                    Text(topic)
                        .font(.system(size: 30))
                        .bold()
                        .padding(.bottom, 5)
                }
                .padding()
                VStack(alignment: .leading, spacing: 25) {
                    if topic == "Physical Health Quiz" {
                        let amountOfTrue = health.physicalHealth.filter { $0.checked }.count

                        if amountOfTrue == 0 {
                            Text("You checked 0 boxes! You seem to have amazing physical health! Stay strong and keep putting in the effort!")
                        } else if amountOfTrue < 4 {
                            Text("You checked \(amountOfTrue) boxes. Seems like some things are bothering you. Its important to master your physical health. Try getting more social, changing your diet, and keep checking in on yourself.")
                        } else if amountOfTrue >= 5 {
                            Text("You checked \(amountOfTrue) boxes. Here are some tips to improve your physical health. Try to get more sleep, eat healthier, and take care of your mental and social health. Remember, all aspects of health matter and you can get advice from anywhere. Good luck!")
                        }
                    } else if (topic == "Mental Health Quiz") {
                        if topic == "Mental Health Quiz" {
                            let amountOfTrue = health.mentalHealth.filter { $0.checked }.count

                            if amountOfTrue == 0 {
                                Text("You checked 0 boxes! You seem to have amazing mental health! Stay strong and keep putting in the effort!")
                            } else if amountOfTrue < 4 {
                                Text("You checked \(amountOfTrue) boxes. Seems like some things are bothering you. Its important to master your physical health. Try getting more social, changing your diet, and keep checking in on yourself.")
                            } else if amountOfTrue >= 5 {
                                Text("You checked \(amountOfTrue) boxes. Here are some tips to improve your physical health. Try to get more sleep, eat healthier, and take care of your physical and social health. Remember, all aspects of health matter and you can get advice from anywhere. Good luck!")
                            }
                        }
                    } else if topic == "Social Health Quiz" {
                        if topic == "Social Health Quiz" {
                            let amountOfTrue = health.socialHealth.filter { $0.checked }.count

                            if amountOfTrue == 0 {
                                Text("You checked 0 boxes! You seem to have amazing social health! Stay strong and keep putting in the effort!")
                            } else if amountOfTrue < 4 {
                                Text("You checked \(amountOfTrue) boxes. Seems like some things are bothering you. Its important to master your physical health. Try getting more social, changing your diet, and keep checking in on yourself.")
                            } else if amountOfTrue >= 5 {
                                Text("You checked \(amountOfTrue) boxes. Here are some tips to improve your physical health. Try to get more sleep, eat healthier, and take care of your mental and physical health. Remember, all aspects of health matter and you can get advice from anywhere. Good luck!")
                            }
                        }
                    }
                }
                .padding()
                Spacer()
            }
        }
    }
}
