//
//  AttentionSpanPage.swift
//  ZoneMaze
//
//  Created by Ali AI on 12/30/23.
//

import Foundation
import SwiftUI
import AVKit

struct WhiteNoisePage: View {
    @Binding var theme: String
    
    @State var player: AVAudioPlayer!
    @State var audioOptions = [
        "Heater": "paused",
        "Fan": "paused",
        "Dryer": "paused",
        "Ocean": "paused",
        "Water_Boiling": "paused",
        "Blender": "paused",
        "White_Noise": "paused",
        "Rain": "paused",
        "Train": "paused",
        "Water_Fall": "paused",
        "Waves": "paused"
    ]
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    HStack() {
                        Text("White Noise")
                            .padding()
                            .font(.system(size: 27))
                            .bold()
                        Spacer()
                    }
                    List(audioOptions.sorted(by: >), id: \.key) { key, value in
                        HStack {
                            if value == "paused" {
                                Button(action: {
                                    let sound = Bundle.main.path(forResource: key, ofType: "mp3")
                                    self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                                    self.player.numberOfLoops = -1
                                    self.player.play()
                                    self.audioOptions[key] = "play"
                                    
                                    for i in audioOptions.sorted(by: >) {
                                        if i.value == "play" {
                                            if i.key != key {
                                                self.audioOptions[i.key] = "paused"
                                            }
                                        }
                                    }
                                }, label: {
                                        Image(systemName: "play.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                })
                            } else {
                                Button(action: {
                                    let sound = Bundle.main.path(forResource: key, ofType: "mp3")
                                    self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                                    self.player.pause()
                                    self.audioOptions[key] = "paused" 
                                }, label: {
                                    Image(systemName: "pause.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                })
                            }
            
                            Spacer()
                            Text(key.replacingOccurrences(of: "_", with: " "))
                                .bold()
                        }
                        .frame(width: geo.size.width * 0.85)
                        .padding()
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .onAppear() {
            
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback)
                    try AVAudioSession.sharedInstance().setActive(true)
                } catch {
                    print("Failed: \(error.localizedDescription)")
                }
            }

        }
    }
}
