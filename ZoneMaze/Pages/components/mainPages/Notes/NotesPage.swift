import SwiftUI


struct NotesPage: View {
    @Binding var theme: String
    @Binding var isNavbarShowing: Bool
    
    @ObservedObject var items = TheObservedObject()
    
    @State private var isPopoverOpen = false
    @State private var noteName = ""
    @State private var noteDescription = ""
    @State private var noteRemind = false
    @State private var markImportant = false
    @State private var noteAddInfo = ""
    @State private var date = Date.now

    func formatTheDate(arg: Date) -> String {
        let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy h:mm a"
                dateFormatter.timeZone = TimeZone.current

                return dateFormatter.string(from: arg)
                
    }
    
    var body: some View {
        GeometryReader {geo in
            VStack {
                HStack(alignment: .center) {
                    Text("Notes/Reminders")
                        .bold()
                        .font(.system(size: 23))
                    Spacer()
                    Button {
                        isPopoverOpen = true
                    } label: {
                        Image(systemName: "plus.app.fill")
                            .foregroundColor(Color[theme])
                            .font(.system(size: 24))
                    }

                    
                }
                .padding()
                .popover(isPresented: $isPopoverOpen) {
                    
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("Add Note")
                            .bold()
                        TextField("Name...", text: $noteName)
                            .frame(width: geo.size.width * 0.8)
                            .padding(10)
                            .cornerRadius(3.0)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .background(Color.gray.opacity(0.3))
                        
                        TextField("Description...", text: $noteDescription)
                            .frame(width: geo.size.width * 0.8)
                            .padding(10)
                            .cornerRadius(3.0)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .background(Color.gray.opacity(0.3))
                        
                        Button(action: {
                            items.item.append(Item(title: noteName, description: noteDescription))
                              
                            noteName = ""
                            noteDescription = ""
                            isPopoverOpen = false
                            
                        }, label: {
                            Text("Add Note")
                                .frame(width: geo.size.width * 0.85, height: 40)
                                .foregroundColor(.white)
                                .background(Color[theme])
                                .cornerRadius(3.0)
                            
                        })
                        
                    }
                    .frame(width: geo.size.width * 0.5)
                }
                
                
                List {
                    Text("Your Notes/Reminders")
                        .bold()
                    
                    ForEach(items.item, id: \.self) { item in
                        VStack(alignment:  .leading, spacing: 10) {
                            Text("\(item.title)")
                            
                            Text("\(item.description)")
                                .font(.system(size: 13))
                             
                        }
                        .padding(5)
                        
                    }
                    .onDelete { indexSet in
                        items.item.remove(atOffsets: indexSet)
                    }
                    .onMove { indexSet, index in
                        items.item.move(fromOffsets: indexSet, toOffset: index) 
                    }
                    
                    
                }
                .toolbar {
                    EditButton()
                }
            }
            .onAppear {
                
//                if let theItems = retrieveAllItems() {
//                    items += theItems
//                }
                isNavbarShowing = true
            }
        }
        
       
    }
}
