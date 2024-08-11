//
//  ZoneMazeApp.swift
//  ZoneMaze
//
//  Created by Ali AI on 12/26/23.
//

import SwiftUI
import UserNotifications
import Firebase

extension Color {
    static subscript(cName: String) -> Color {
        let colorMap: [String: Color] = [
            "blue": Color.blue,
            "red": Color.red,
            "yellow": Color.yellow,
            "orange": Color.orange,
            "pink": Color.pink,
            "purple": Color.purple,
            "green": Color.green,
            "brown": Color.brown,
            "mint": Color.mint,
            "indigo": Color.indigo,
            "teal": Color.teal,
            "gray": Color.gray,
            "black": Color.black,
            "cyan": Color.cyan
        ]
        
        return colorMap[cName]!
    }
}

@main
struct ZoneMazeApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear() {
                    let notifications = UNUserNotificationCenter.current() 
                    notifications.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                        if granted {
                            print("Done")
                        } else {
                            print("Denied")
                        }
                    }
                }  
        }
    }
}

