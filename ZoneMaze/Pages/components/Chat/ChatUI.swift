//
//  ChatUI.swift
//  ZoneMaze
//
//  Created by Ali AI on 5/10/24.
//

import Foundation
import SwiftUI 

struct ChatUI: View {
    @State var scrollToBottom = false
    @AppStorage("theme") var theme = "orange"
    @State var time = false
    @State var name = "Send a message"
    @State var isSend = false
    @State var formatter = DateFormatter()
    
    @State private var text = ""
    @ObservedObject var manager = Manager()
     
    func dateFormat(_ date: Date) -> String {
        formatter.dateFormat = "hh:mm"
        let newDate = formatter.string(from: date)
        return newDate
    }
    @State var isJumpOne = false
    @State var isJumpTwo = false
    @State var isJumpThree = false
    @State var isJumpFour = false
    @State var isJumpFive = false
    @State var isJumpSix = false
    @State var isJumpSeven = false
    
    @State var assign = true
    
    var body: some View {
        if time {
            LoadingComponent(theme: $theme, time: $time)
        } else {
            ZStack {
                if manager.isLoading {
                    ZStack {
                        VStack {
                            Spacer()
                            HStack(spacing: 3) {
                                Spacer()
                                Circle()
                                    .fill(Color[theme])
                                    .frame(width: 30, height: 30)
                                    .animation(
                                        Animation.easeInOut(duration: 0.5)
                                            .repeatForever(autoreverses: true)
                                    )
                                    .offset(y: isJumpOne ? -600 : 0)
                                    .onAppear() {
                                        isJumpOne.toggle()
                                    }
                                Circle()
                                    .fill(Color[theme])
                                    .frame(width: 30, height: 30)
                                    .animation(
                                        Animation.easeInOut(duration: 0.5)
                                            .repeatForever(autoreverses: true)
                                            .delay(0.3)
                                    )
                                    .offset(y: isJumpTwo ? -600 : 0)
                                    .onAppear() {
                                        isJumpTwo.toggle()
                                    }
                                Circle()
                                    .fill(Color[theme])
                                    .frame(width: 30, height: 30)
                                    .animation(
                                        Animation.easeInOut(duration: 0.5)
                                            .repeatForever(autoreverses: true)
                                            .delay(0.5)
                                    )
                                    .offset(y: isJumpThree ? -600 : 0)
                                    .onAppear() {
                                        isJumpThree.toggle()
                                    }
                                Circle()
                                    .fill(Color[theme])
                                    .frame(width: 30, height: 30)
                                    .animation(
                                        Animation.easeInOut(duration: 0.5)
                                            .repeatForever(autoreverses: true)
                                            .delay(0.7)
                                    )
                                    .offset(y: isJumpFour ? -600 : 0)
                                    .onAppear() {
                                        isJumpFour.toggle()
                                    }
                                Circle()
                                    .fill(Color[theme])
                                    .frame(width: 30, height: 30)
                                    .animation(
                                        Animation.easeInOut(duration: 0.5)
                                            .repeatForever(autoreverses: true)
                                            .delay(0.9)
                                    )
                                    .offset(y: isJumpFive ? -600 : 0)
                                    .onAppear() {
                                        isJumpFive.toggle()
                                    }
                                Circle()
                                    .fill(Color[theme])
                                    .frame(width: 30, height: 30)
                                    .animation(
                                        Animation.easeInOut(duration: 0.5)
                                            .repeatForever(autoreverses: true)
                                            .delay(1.1)
                                    )
                                    .offset(y: isJumpSix ? -600 : 0)
                                    .onAppear() {
                                        isJumpSix.toggle()
                                    }
                                Circle()
                                    .fill(Color[theme])
                                    .frame(width: 30, height: 30)
                                    .animation(
                                        Animation.easeInOut(duration: 0.5)
                                            .repeatForever(autoreverses: true)
                                            .delay(1.3)
                                    )
                                    .offset(y: isJumpSeven ? -600 : 0)
                                    .onAppear() {
                                        isJumpSeven.toggle()
                                    }
                                Spacer()
                            }
                        }
                        VStack {
                            Spacer()
                            Text("Loading")
                                .bold()
                                .font(.title)
                            Spacer()
                        }
                    }
                } else {
                    ZStack {
                        VStack(alignment: .leading) {
                            ScrollViewReader { scrollView in
                                ScrollView(showsIndicators: false ) {
                                    VStack {
                                        VStack(spacing: 5) {
                                            Text("You're now chatting with someone")
                                                .bold()
                                                .padding(.top)
                                                .font(.system(size: 20))
                                            Text(manager.chatId)
                                            Text("This chat is anonymous")
                                                .bold()
                                                .foregroundStyle(.gray)
                                                .font(.system(size: 15))
                                        }
                                        .padding(.top)
                                        .padding(.bottom)
                                        HStack {
                                            ForEach(manager.messages, id: \.self) { i in
                                                VStack(alignment: .leading) {
                                                    HStack {
                                                        if Int(i.person) == 0 {
                                                            Text("You")
                                                                .bold()
                                                        } else {
                                                            Text("Other")
                                                                .bold()
                                                        }
                                                    }
                                                    Text(i.message)
                                                        .padding(.trailing)
                                                }
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .padding(.leading)
                                                .padding(.bottom)
                                                Spacer()
                                            }
                                            .frame(maxWidth: .infinity)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.bottom)
                        .padding(.bottom)
                        .padding(.bottom)
                        .padding(.bottom)
                        VStack {
                            Spacer()
                            Input(name: $name, text: $text, includeMag: .constant(false), includeSend: .constant(true), isSend: $isSend)
                                .background(Color.white)
                                .onTapGesture {
                                    scrollToBottom.toggle()
                                }
                                .onChange(of: isSend) { one, two in
                                    if isSend == true {
                                        manager.sendMessage(text: text)
                                        isSend = false
                                        text = ""
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

