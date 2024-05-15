//
//  ContentView.swift
//  ZoneMaze
//
//  Created by Ali AI on 1/15/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("loadingScreen") var theTime = false
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    @AppStorage("isNavbarShowing") var isNavbarShowing = false
    @AppStorage("theme") var theme = "orange"
    @AppStorage("currentNav") var currentNav = "One"
    @AppStorage("allItems") var allItems: Data?
    @AppStorage("allNewItems") var allNewItems: Data?
    @AppStorage("goodDays") var goodDays = 0
    @AppStorage("setUrgentTask") var setUrgentTask = ""
    @AppStorage("isNew") var isNew = true
    
    var body: some View {
        if theTime == true {
            LoadingComponent(theme: $theme, time: $theTime) 
        } else {
            if isLoggedIn == false {
                WelcomePage(theme: $theme, isLoggedIn: $isLoggedIn, isNavbarShowing: $isNavbarShowing)
            } else {
                NavbarComponent(currentNav: $currentNav, theme: $theme, isLoggedIn: $isLoggedIn, allItems: $allItems, allNewItems: $allNewItems, goodDays: $goodDays, setUrgentTask: $setUrgentTask, theTime: $theTime, isNew: $isNew)
            }
        }
    }
}

// Homepage, Calendar, Notes, games, White Noise, Chat
