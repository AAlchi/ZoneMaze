//
//  Meditation.swift
//  ZoneMaze
//
//  Created by Ali AI on 2/24/24.
//

import Foundation
import SwiftUI
import CoreHaptics

struct Meditation: View {
    @Environment(\.dismiss) var dismiss
    @State var title = "Meditation"
    @State var description = "Meditatation can help you improve in many ways with your health. Take this meditation guide to create a beautiful reflection environment."
    @State var isPresented = true
    @State var theTime = true
    @State var times = 0
    @State var meditationText = "Breath In"
    @State var path: [String] = []
    
    @State private var engine: CHHapticEngine?
    
    @State var hapticRan = false
    
    func HapticFunction() {
        if !hapticRan {
            do {
                engine = try CHHapticEngine()
                try engine?.start()
            } catch {
                print("There was an error")
            }
            hapticRan = true
        } else {
            if times < 38 {
                var events = [CHHapticEvent]()
                
                let intenseVar = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
                let sharpnessVar = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
                let newEvent = CHHapticEvent(eventType: .hapticTransient, parameters: [intenseVar, sharpnessVar], relativeTime: 0)
                events.append(newEvent)
                
                do {
                    let CHHHPattern = try CHHapticPattern(events: events, parameters: [])
                    let player = try engine?.makePlayer(with: CHHHPattern)
                    try player?.start(atTime: 0)
                    times += 1
                } catch {
                    print("Error")
                }
            }
        }
    }
    
    @AppStorage("theme") var theme = "orange"
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Circle()
                    .overlay {
                        Text(meditationText)
                            .foregroundStyle(.white)
                            .font(.system(size: 35))
                            .onAppear {
                                Timer.scheduledTimer(withTimeInterval: 4,  repeats: theTime) { timer in
                                    withAnimation {
                                        if meditationText == "Breath In" {
                                            meditationText = "Breath Out"
                                            HapticFunction()
                                        } else {
                                            meditationText = "Breath In"
                                            HapticFunction()
                                        }
                                        if times > 19 {
                                            theTime = false
                                            meditationText = "All Done!"
                                        }
                                        
                                    }
                                }
                            }
                    }
                Spacer()
            }
            Spacer()
        }.onAppear(perform: HapticFunction)
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
