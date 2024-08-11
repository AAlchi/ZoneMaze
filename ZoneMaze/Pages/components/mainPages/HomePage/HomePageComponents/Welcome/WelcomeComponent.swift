//
//  WelcomeComponent.swift
//  ZoneMaze
//
//  Created by Ali AI on 5/2/24.
//

import Foundation
import SwiftUI

struct WelcomeComponent: View {
    @Binding var theme: String
    @Binding var allItems: Data?
    @State var isLoading = false
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("isNew") var isNew = false
    
    @AppStorage("loadingScreen") var theTime = false
    // dark and light mode
    @Environment(\.colorScheme) var colorScheme
    
    
    // sorting
    @State private var allThings = [
        "added": ["Settings", "Chat", "Profile", "Log Out"],
        "not added": []
    ]
    
    @State var isPopoverPresented = false
    @State var isChatPopoverPresented = false
    @State var isChosen = false
    @State var type = ""
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    HStack(spacing: 3) {
                        Text("Hello, Test!")
                            .font(.system(size: 23))
                            .bold()
                    }
                    
                    Spacer()
                    
                    Button("\(Image(systemName: "pencil.circle"))") {
                        isPopoverPresented = true
                    }
                    .frame(width: 35, height: 35)
                    .font(.system(size: 20))
                    .foregroundColor(Color[theme])
                    .cornerRadius(50.0, antialiased: true)
                }
                LazyVGrid(columns: columns) {
                    ForEach(allThings["added"]!, id: \.self) { i in
                        if i == "Settings" {
                            NavigationLink(destination: SettingsComponent(theme: $theme, theTime: $theTime)) {
                                WelcomeComponentButton(name: .constant("Settings"), image: .constant("gear"))
                            }
                        } else if i == "Chat" {
                            NavigationLink(destination: ChatComponent()) {
                                WelcomeComponentButton(name: .constant("Chat"), image: .constant("message"))
                            }
                        } else if i == "Profile" {
                            NavigationLink(destination: Profile()) {
                               WelcomeComponentButton(name: .constant("Profile"), image: .constant("person.circle"))
                            }
                        } else if i == "Log Out" {
                            Button {
                                isLoggedIn = false
                                isNew = true
                                theTime = true
                            } label: {
                                WelcomeComponentButton(name: .constant("Log Out"), image: .constant("rectangle.portrait.and.arrow.right.fill"))
                            }
                        }
                    }
                }
                .popover(isPresented: $isPopoverPresented) {
                    VStack {
                        HStack {
                            Text("Edit \("More Options")")
                                .bold()
                                .font(.system(size: 23))
                            Spacer()
                            EditButton()
                        }.padding()
                            .padding(.top)
                        
                        VStack(alignment: .leading) {
                            List {
                                Section(header: Text("Added")) {
                                    ForEach(allThings["added"]!, id: \.self) { i in
                                        HStack {
                                            Text("\(Image(systemName: "minus.circle"))")
                                                .foregroundStyle(Color.red)
                                                .onTapGesture {
                                                    updateItem("\(i)", from: "added", to: "not added")
                                                }
                                            Text("\(i)")
                                        }
                                        
                                    }
                                    .onMove { indices, newOffset in
                                        self.allThings["added"]!.move(fromOffsets: indices, toOffset: newOffset)
                                    }
                                    
                                    
                                }
                                Section(header: Text("Not Added")) {
                                    
                                    
                                    ForEach(allThings["not added"]!, id: \.self) { i in
                                        HStack {
                                            Text("\(Image(systemName: "plus.app"))")
                                                .foregroundStyle(Color.green)
                                                .onTapGesture {
                                                    updateItem("\(i)", from: "not added", to: "added")
                                                }
                                            Text("\(i)")
                                        }
                                    }
                                    
                                }
                            }
                            .listStyle(PlainListStyle())
                            .listRowInsets(nil)
                        }
                    }
                    .onDisappear {
                        if let encodedItems = try? JSONEncoder().encode(allThings) {
                            allItems = encodedItems
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                if let storedItems = allItems,
                   let decodedItems = try? JSONDecoder().decode([String: [String]].self, from: storedItems) {
                    allThings = decodedItems
                }
            }
        }
    }
    
    func updateItem(_ item: String, from section: String, to newSection: String) {
        guard var sourceSection = allThings[section],
              let theIndex = sourceSection.firstIndex(of: item) else {
            return
        }
        
        sourceSection.remove(at: theIndex)
        
        if var destinationSection = allThings[newSection] {
            destinationSection.append(item)
            allThings[section] = sourceSection
            allThings[newSection] = destinationSection
        }
    }
}

