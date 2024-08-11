//
//  MoreOptions.swift
//  ZoneMaze
//
//  Created by Ali AI on 12/28/23.
//

import Foundation
import SwiftUI

struct MoreOptionsComponent: View {
    @Binding var theme: String
    @Binding var isLoggedIn: Bool
    @Binding var theTime: Bool
    @Binding var allItems: Data?
    @Binding var isNew: Bool
    @State var isLoading = false
    @AppStorage("allNewItems") var allNewItems: Data?

    // dark and light mode
    
    @Environment(\.colorScheme) var colorScheme
    
    
    // sorting
    
    
    @State private var allThings = [
        "added": ["Settings", "Chat", "Profile", "Log Out"],
        "not added": []
    ]
    
    @State var isPopoverPresented = false
    var body: some View {
            VStack {
                HStack(alignment: .center) {
                    Text("More Options")
                        .bold()
                        .font(.system(size: 23))
                    Spacer()
                    Button("\(Image(systemName: "pencil.circle"))") {
                        isPopoverPresented = true
                    }
                    .foregroundColor(Color[theme])
                }.padding()
                
                VStack {
                    ForEach(allThings["added"]!, id: \.self) { i in
                        if i == "Settings" {
                            NavigationLink(destination: SettingsComponent(theme: $theme, theTime: $theTime)) {
                                HStack {
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        
                                        if colorScheme == .dark {
                                            Text("\(i)")
                                                .foregroundStyle(Color.white)
                                        } else {
                                            Text("\(i)")
                                                .foregroundStyle(Color.black)
                                        }
                                        
                                    }
                                    .frame(width: 300)
                                    .padding(15)
                                    .background(Color.gray.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 7.0))
                                    Spacer()
                                }
                            }
                        }
                        if i == "Chat" {
                            NavigationLink(destination: ChatComponent()) {
                                HStack {
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        
                                        if colorScheme == .dark {
                                            Text("\(i)")
                                                .foregroundStyle(Color.white)
                                        } else {
                                            Text("\(i)")
                                                .foregroundStyle(Color.black)
                                        }
                                        
                                    }
                                    .frame(width: 300)
                                    .padding(15)
                                    .background(Color.gray.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 7.0))
                                    Spacer()
                                }
                            }
                        }
                        if i == "Profile" {
                            
                            NavigationLink(destination: Profile()) { 
                                HStack {
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        if colorScheme == .dark {
                                            Text("\(i)")
                                                .foregroundStyle(Color.white)
                                        } else {
                                            Text("\(i)")
                                                .foregroundStyle(Color.black)
                                        }
                                    }
                                    .frame(width: 300)
                                    .padding(15)
                                    .background(Color.gray.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 7.0))
                                    Spacer()
                                }
                            }
                        }
                        if i == "Log Out" {
                            
                            Button {
                                theTime = true
                                isLoggedIn = false
                                isNew = true
                            } label: {
                                HStack {
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        if colorScheme == .dark {
                                            Text("\(i)")
                                                .foregroundStyle(Color.white)
                                        } else {
                                            Text("\(i)")
                                                .foregroundStyle(Color.black)
                                        }
                                    }
                                    .frame(width: 300)
                                    .padding(15)
                                    .background(Color.gray.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 7.0))
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                }
                .padding()
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
                            allNewItems = encodedItems
                        }
                    }
                }
            }
            .onAppear {
                if let itemsStored = allNewItems,
                   let itemsDecoded = try? JSONDecoder().decode([String: [String]].self, from: itemsStored) {
                    allThings = itemsDecoded
                }
            } 
    }
    func updateItem(_ item: String, from section: String, to newSe: String) {
        guard var checkSe = allThings[section],
              let theIndex = checkSe.firstIndex(of: item) else {
            return
        }
        
        checkSe.remove(at: theIndex)
        
        if var destinationCh = allThings[newSe] {
            destinationCh.append(item)
            allThings[section] = checkSe
            allThings[newSe] = destinationCh
        }
    }
    
}

