import SwiftUI

struct HomePage: View {
    @Binding var theme: String
    @Binding var isLoggedIn: Bool
    @Binding var isNavbarShowing: Bool
    @Binding var allItems: Data?
    @Binding var allNewItems: Data?
    @Binding var goodDays: Int
    @Binding var currentNav: String
    @Binding var theTime: Bool
    @Binding var isNew: Bool
    
    @State var isLoading = false
    func refreshData() async {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
    }
    @State var isPopoverShowing = false
    @State private var allThings = [
        "added": ["Schedule", "Quote", "Health", "More Options"],
        "not added": []
    ]
    @State var isTrue = true
    @State var isFalse = false
    @State var isAlert = false
    @State var tOpacity = 0.0
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                VStack {
                    HStack {
                        Text("ZoneMaze")
                            .font(.system(size: 28))
                            .padding(20)
                            .bold()
                        Spacer()
                        HStack(spacing: 1) {
                            Spacer()
                            Button("\(Image(systemName: "pencil.circle"))") {
                                isPopoverShowing = true
                            }
                            .frame(width: 35, height: 35)
                            .font(.system(size: 20))
                            .foregroundColor(Color[theme])
                            .cornerRadius(50.0, antialiased: true)
                            .padding()
                            
                        }
                    }
                    .popover(isPresented: $isPopoverShowing) {
                        VStack {
                            HStack {
                                Text("Edit \("Home Page")")
                                    .bold()
                                    .font(.system(size: 23))
                                Spacer()
                                EditButton()
                                    .foregroundStyle(Color[theme])
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
                    }
                    VStack {
                        if isLoading == true {
                            ZStack {
                                LoadingComponent(theme: $theme, time: $isLoading)
                                    .onAppear {
                                        isLoading = true
                                        Timer.scheduledTimer(withTimeInterval: 2,  repeats: false) { timer in
                                            withAnimation {
                                                isLoading = false
                                            }
                                        }
                                    }
                            }
                        }
                        ScrollView {
                            
                            WelcomeComponent(theme: $theme, allItems: $allNewItems)
                            ForEach(allThings["added"]!, id: \.self) { item in
                                    switch item {
                                    case "Quote":
                                        QuotesComponent(theme: $theme)
                                    case "Schedule":
                                        ScheduleComponent(theme: $theme, currentNav: $currentNav)
                                    case "Health":
                                        HealthComponent(theme: $theme)
                                    case "More Options" :
                                        MoreOptionsComponent(theme: $theme, isLoggedIn: $isLoggedIn, theTime: $theTime, allItems: $allItems, isNew: $isNew)
                                    default:
                                        Text("Empty Page")
                                    }
                            }
                            if (allThings["added"]!.isEmpty) {
                                Text("It looks like your page is empty")
                                    .padding(.top)
                                    .bold()
                                    .font(.system(size: 27))
                                Text("Go to the top right to edit your screen")
                                    .padding(.top, 2)
                            }
                            HStack {
                                Text(" ")
                            }.padding()
                                .frame(height: 100)
                        }
                    }
                }
                .opacity(tOpacity)
                .onAppear {
                    isNavbarShowing = true
                    if let storedItems = allItems,
                       let decodedItems = try? JSONDecoder().decode([String: [String]].self, from: storedItems) {
                        allThings = decodedItems
                    }
                    
                    withAnimation(.easeIn(duration: 1)) {
                        tOpacity = 1.0
                    }
                }
                .refreshable {
                    await refreshData()
                }
            }
            .onAppear {
                isNavbarShowing = true 
            }
        }
    }
    
    
    func updateItem(_ item: String, from section: String, to newSection: String) {
        guard var theSourceSection = allThings[section],
              let theIndex = theSourceSection.firstIndex(of: item) else {
            return
        }
        
        theSourceSection.remove(at: theIndex)
        
        if var theDestinationSection = allThings[newSection] {
            theDestinationSection.append(item)
            allThings[section] = theSourceSection
            allThings[newSection] = theDestinationSection
        }
        
        if let encodedItems = try? JSONEncoder().encode(allThings) {
            allItems = encodedItems
        }
    }
}

