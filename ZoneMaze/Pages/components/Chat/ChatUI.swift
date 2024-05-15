//
//  ChatUI.swift
//  ZoneMaze
//
//  Created by Ali AI on 5/10/24.
//

import Foundation
import SwiftUI

struct MessageData: Hashable {
    var person: Int
    var message: String
    var time: Date
}

struct ChatUI: View {
    @State var messages: [MessageData] = []
    
    @State var scrollToBottom = false
    
    @AppStorage("theme") var theme = "orange"
    @State var time = false
    
    @State var name = "Send a message"
    @State var text = ""
    @State var isSend = false
    @State var formatter = DateFormatter()
    
    func dateFormat(_ date: Date) -> String {
        formatter.dateFormat = "hh:mm"
        let newDate = formatter.string(from: date)
        return newDate
    }
    
    var body: some View {
        if time {
            LoadingComponent(theme: $theme, time: $time)
        } else {
            ZStack {
                VStack(alignment: .leading) {
                    ScrollViewReader { scrollView in
                        ScrollView(showsIndicators: false ) {
                            VStack {
                                VStack(spacing: 5) {
                                    Text("You're now chatting with AI")
                                        .bold()
                                        .padding(.top)
                                        .font(.system(size: 20))
                                    Text("This chat is anonymous")
                                        .bold()
                                        .foregroundStyle(.gray)
                                        .font(.system(size: 15))
                                }
                                .padding(.top)
                                .padding(.bottom)
                                ForEach(messages, id: \.self) { i in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                if Int(i.person) == 0 {
                                                    Text("You")
                                                        .bold()
                                                } else {
                                                    Text("Other")
                                                        .bold()
                                                }
                                                Text("\(dateFormat(i.time))")
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
                                let new = MessageData(person: 0, message: text, time: Date())
                                messages.append(new)
                                isSend = false
                                text = ""
                            }
                        }
                }
            }
        }
    }
}

