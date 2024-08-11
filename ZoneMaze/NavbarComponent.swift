import SwiftUI

struct NavbarComponent: View {
    @State var currentNav = "One"
    @Binding var theme: String
    @Binding var isLoggedIn: Bool
    @AppStorage("isNavbarShowing") var isNavbarShowing = true
    @Binding var allItems: Data?
    @Binding var allNewItems: Data?
    @Binding var goodDays: Int
    @Binding var theTime: Bool
    @Binding var isNew: Bool
    
    var body: some View { 
            TabView(selection: $currentNav) {
                Group {
                    HomePage(theme: $theme, isLoggedIn: $isLoggedIn, isNavbarShowing: $isNavbarShowing, allItems: $allItems, allNewItems: $allNewItems, goodDays: $goodDays, currentNav: $currentNav, theTime: $theTime, isNew: $isNew)
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                        .tag("One")
                    WeeklySchedulesPage()
                        .tabItem {
                            Label("Calendar", systemImage: "calendar")
                        }
                        .tag("Two")
                    NotesPage(theme: $theme, isNavbarShowing: $isNavbarShowing)
                        .tabItem {
                            Label("Notes", systemImage: "note.text")
                        }
                        .tag("Three")
                    GamesPage(theme: $theme)
                        .tabItem {
                            Label("Games", systemImage: "gamecontroller")
                        }
                        .tag("Four")
                    WhiteNoisePage(theme: $theme)
                        .tabItem {
                            Label("White Noise", systemImage: "person.and.background.dotted")
                        }
                        .tag("Five")
                }
                .padding(.top)
            }
            .tint(Color[theme])
    }
}


