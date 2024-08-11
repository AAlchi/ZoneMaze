//
//  Reminders.swift
//  ZoneMaze
//
//  Created by Ali Alchikh Ibrahim on 9/18/23.
//

import SwiftUI

struct RemindersPage: View {
    @State var items:[Item] = []
    @State var popoverPresent = false
    @State var popoverNotePresent = false
    
    //note
    @State var noteName = ""
    @State var noteDescription = ""
    @AppStorage("isNavbarShowing") var isNavbarShowing = false
    
    
    var body: some View {
        GeometryReader {geo in
            VStack {
                Text("Reminders/Notes")
                    .font(.system(size: 20))
                    .bold()
                HStack {
                    HStack {
                        Button(action: {
                            popoverPresent = true
                        }, label: {
                            Text("Set a Reminder")
                                .frame(width: geo.size.width * 0.4, height: 40)
                                .foregroundColor(.white)
                                .background(Color.orange.opacity(0.8))
                                .cornerRadius(3.0)
                                .padding()
                        })
                        .popover(isPresented: $popoverPresent) {
                            Text("Your content here")
                                .font(.headline)
                                .padding()
                        }
                        
                        Button(action: {
                            popoverNotePresent = true
                        }, label: {
                            Text("Create a Note")
                                .frame(width: geo.size.width * 0.4, height: 40)
                                .foregroundColor(.white)
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(3.0)
                                .padding()
                        })
                        .popover(isPresented: $popoverNotePresent) {
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Create a Note")
                                    .bold()
                                    .font(.system(size: 25))
                                TextField("Name", text: $noteName)
                                    .frame(width: geo.size.width * 0.7, height: 5)
                                    .padding()
                                    .background(.gray.opacity(0.4))
                                    .clipShape(RoundedRectangle(cornerRadius: 3.0))
                                    .foregroundStyle(.white)
                                TextField("Description", text: $noteDescription)
                                    .frame(width: geo.size.width * 0.7, height: 5)
                                    .padding()
                                    .background(.gray.opacity(0.4))
                                    .clipShape(RoundedRectangle(cornerRadius: 3.0))
                                    .foregroundStyle(.white)
                                Button(action: {
                                    //code
                                }, label: {
                                    Text("Add Note")
                                })
                                .frame(width: geo.size.width * 0.5, height: 40)
                                .background(.orange.opacity(0.7))
                                .clipShape(RoundedRectangle(cornerRadius: 3.0))
                                .foregroundStyle(.white)
                            }
                        }
                    }
                }
                
                List {
                    Text("Your Notes")
                        .bold()
                    
                    ForEach(items, id: \.self) { item in
                        VStack(alignment:  .leading) {
                            Text("\(item.title)")
                                .padding(10)
                            Text("\(item.description)")
                                .font(.system(size: 13))
                        }
                        
                        
                    }
                    .onDelete { indexSet in
                        items.remove(atOffsets: indexSet)
                    }
                    .onMove { indexSet, index in
                        items.move(fromOffsets: indexSet, toOffset: index)
                    }
                    
                    
                    Text("Your Reminders")
                        .bold()
                    
                    ForEach(items, id: \.self) { item in
                        VStack(alignment:  .leading) {
                            Text("\(item.title)")
                                .padding(10)
                            Text("\(item.description)")
                                .font(.system(size: 13))
                        }
                        
                        
                    }
                    .onDelete { indexSet in
                        items.remove(atOffsets: indexSet)
                    }
                    .onMove { indexSet, index in
                        items.move(fromOffsets: indexSet, toOffset: index)
                    }
                    
                }
                .toolbar {
                    EditButton()
                    ShareLink(item: "Note:  + item.title +  Content:  + item.description")
                }
            }
            .onAppear {
                isNavbarShowing = false
            }
        }
    }
}
