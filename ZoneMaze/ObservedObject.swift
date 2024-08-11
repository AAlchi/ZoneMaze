//
//  ObservedObject.swift
//  ZoneMaze
//
//  Created by Ali AI on 2/16/24.
//

import Foundation
import SwiftUI
import UserNotifications
import UserNotificationsUI

class TheObservedObject: ObservableObject {
    @Published var notify = false
    @Published var notifyText = ""
    @Published var item = [Item]() {
        didSet {
            saveData(arg: "item", key: "item")
        }
    }
    
    @Published var scheduleItem = [ScheduleItem]() {
        didSet {
            saveData(arg: "week", key: "week")
        }
    }
    
    @Published var scheduleScheduleItem = [ScheduleScheduleItem]() {
        didSet {
            saveData(arg: "day", key: "day")
        }
    }
    
    @Published var physicalHealth = [PhysicalHealth]() {
        didSet {
            saveData(arg: "physical", key: "physical")
        }
    }
    
    @Published var mentalHealth = [MentalHealth]() {
        didSet {
            saveData(arg: "mental", key: "mental")
        }
    }
    
    @Published var socialHealth = [SocialHealth]() {
        didSet {
            saveData(arg: "social", key: "social")
        }
    }
    
    func setNotification(title: String, description: String, hour: Int, minute: Int) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = description
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "ZoneMazeReminder"
        content.userInfo = ["person": "description"]
        content.interruptionLevel = .timeSensitive
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        var testDate = DateComponents()
        testDate.hour = hour
        testDate.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: testDate, repeats: false)
        guard let targetDate = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date()) else {
            return
        }
        let timeInterval = targetDate.timeIntervalSince(Date())
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in 
            self.notify = true
            self.notifyText = description
        }
        print(notify)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request) 
    }
     
    
    func getData() {
        let decoder = JSONDecoder()
        if let encodedItems = UserDefaults.standard.data(forKey: "item") {
            if let newItem = try? decoder.decode([Item].self, from: encodedItems) {
                item = newItem
            }
        }
        if let encodedItems2 = UserDefaults.standard.data(forKey: "week") {
            if let newScheduleItem = try? decoder.decode([ScheduleItem].self, from: encodedItems2) {
                scheduleItem = newScheduleItem
            }
        }
        if let encodedItems3 = UserDefaults.standard.data(forKey: "day") {
            if let newScheduleScheduleItem = try? decoder.decode([ScheduleScheduleItem].self, from: encodedItems3) {
                scheduleScheduleItem = newScheduleScheduleItem
            }
        }
        if let encodedItems4 = UserDefaults.standard.data(forKey: "physical") {
            if let newPhysicalHealth = try? decoder.decode([PhysicalHealth].self, from: encodedItems4) {
                physicalHealth = newPhysicalHealth
            }
        }
        if let encodedItems5 = UserDefaults.standard.data(forKey: "mental") {
            if let newMentalHealth = try? decoder.decode([MentalHealth].self, from: encodedItems5) {
                mentalHealth = newMentalHealth
            }
        }
        if let encodedItems6 = UserDefaults.standard.data(forKey: "social") {
            if let newSocialHealth = try? decoder.decode([SocialHealth].self, from: encodedItems6) {
                socialHealth = newSocialHealth
            }
        }
    }
    
    func saveData(arg: String, key: String) {
        let encoder = JSONEncoder()

        if arg == "item" {
            if let encodedItems = try? encoder.encode(item) {
                UserDefaults.standard.set(encodedItems, forKey: key)
            }
        } else if arg == "week" {
            if let encodedItems = try? encoder.encode(scheduleItem) {
                UserDefaults.standard.set(encodedItems, forKey: key)
            }
        } else if arg == "physical" {
            if let encodedItems = try? encoder.encode(physicalHealth) {
                UserDefaults.standard.set(encodedItems, forKey: key)
            }
        } else if arg == "mental" {
            if let encodedItems = try? encoder.encode(mentalHealth) {
                UserDefaults.standard.set(encodedItems, forKey: key)
            }
        } else if arg == "social" {
            if let encodedItems = try? encoder.encode(socialHealth) {
                UserDefaults.standard.set(encodedItems, forKey: key)
            }
        } else if arg == "day" {
            if let encodedItems = try? encoder.encode(scheduleScheduleItem) {
                UserDefaults.standard.set(encodedItems, forKey: key)
            }
             
            let formatter = DateFormatter()
            formatter.dateFormat = "HH"
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "mm"
            let formatter3 = DateFormatter()
            formatter3.dateFormat = "EEEE"
            
            for i in scheduleScheduleItem {
                if i.isScheduled == false {
                    if i.theActualDay == formatter3.string(from: Date()) {
                        setNotification(title: "Calendar", description: i.scheduleTitle, hour: Int(formatter.string(from: i.scheduleDate))!, minute: Int(formatter2.string(from: i.scheduleDate))!)
                     }
                    scheduleScheduleItem.removeAll(where: { $0.id == i.id })
                    scheduleScheduleItem.append(ScheduleScheduleItem(scheduleTitle: i.scheduleTitle, scheduleDate: i.scheduleDate, theActualDay: i.theActualDay, isScheduled: true))
                }
            }
        }
        
    }
    
    init() { 
        getData()
        
        if physicalHealth == [] {
            self.physicalHealth = [
                PhysicalHealth(question: "Do you prefer to stay inside instead of going outside?", checked: false),
                PhysicalHealth(question: "Do you eat healthy? Or manage what you eat?", checked: false),
                PhysicalHealth(question: "Do you exercise at least three times a week for at least 30 minutes?", checked: false),
                PhysicalHealth(question: "Do you get tired easily?", checked: false),
                PhysicalHealth(question: "Are you overweight?", checked: false),
                PhysicalHealth(question: "Is your BMI NOT in between 18.5 and 24.9?", checked: false),
                PhysicalHealth(question: "Are you underweight?", checked: false),
                PhysicalHealth(question: "Does your heartrate go up in a short period of time?", checked: false),
                PhysicalHealth(question: "Is your posture bad?", checked: false),
            ]
        } 
        
        if mentalHealth == [] {
            self.mentalHealth = [
                MentalHealth(question: "Do you like to stay inside more often?", checked: false),
                MentalHealth(question: "Do you like to sit in your room alone?", checked: false),
                MentalHealth(question: "Do you prefer sad music over happy music?", checked: false),
                MentalHealth(question: "Do you feel like you are not needed?", checked: false),
                MentalHealth(question: "Are you always overthinking the smallest details?", checked: false),
                MentalHealth(question: "Is it hard for you to be confident?", checked: false),
                MentalHealth(question: "Are you always comparing yourself to others?", checked: false),
                MentalHealth(question: "Do you feel like people are happier without you?", checked: false),
                MentalHealth(question: "Do you feel like you have a purspose in life?", checked: false),
                MentalHealth(question: "Are you more sad than happy?", checked: false)
            ]
        }
        
        if socialHealth == [] {
            self.socialHealth = [
                SocialHealth(question: "Do you find it hard to make friends?", checked: false),
                SocialHealth(question: "Do you stay at home more than go outside?", checked: false),
                SocialHealth(question: "Do you take out your phone if you are uncomfortable?", checked: false),
                SocialHealth(question: "Do you decline invitations because you are not comfortable showing up?", checked: false),
                SocialHealth(question: "Do you prefer to celebrate your birthday with close people?", checked: false),
                SocialHealth(question: "Is it hard for you to be confident?", checked: false),
                SocialHealth(question: "Do you overthink a conversation during the day?", checked: false),
                SocialHealth(question: "Are you scared of what people think about you?", checked: false),
                SocialHealth(question: "Do you say sorry even if it wasn't your fault?", checked: false),
                SocialHealth(question: "Do you NEVER reflect on the wonders of life?", checked: false)
            ]
        }
        
    }
     
}
