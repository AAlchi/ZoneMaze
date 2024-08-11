//
//  Manager.swift
//  ZoneMaze
//
//  Created by Ali AI on 8/5/24.
//

import Foundation
import SwiftUI
import EventKit

class CalendarManager_Apple: ObservableObject {
    private let eventStore = EKEventStore()
    @Published var events: [EKEvent] = [] 

    func requestAccess(completion: @escaping (Bool) -> Void) {
        eventStore.requestAccess(to: .event) { granted, error in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    func formatTheDate(arg: Date, type: String) -> String {
        let dateFormatter = DateFormatter()
        if type == "weekday" {
            dateFormatter.dateFormat = "EEEE"
        } else if type == "time" {
            dateFormatter.dateFormat = "h:mm a"
        }
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: arg)
    }
    
    func determineDate(date: Date) -> Bool {
        let calendar = Calendar.current
        
        let todaysComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        
        guard let startOfWeek = calendar.date(from: todaysComponents) else {
            return false
        }
        
        let weekday = calendar.component(.weekday, from: startOfWeek)
        let startWeek = calendar.date(byAdding: .day, value: -weekday + calendar.firstWeekday, to: startOfWeek)!
        
        let endWeek = calendar.date(byAdding: .day, value: 6, to: startWeek)!
        
        return date >= startWeek && date <= endWeek
    }
    
    func checkValidation() -> Bool {
        let status = EKEventStore.authorizationStatus(for: .event)
        
        switch status {
        case .authorized:
            return true
        case .denied, .restricted:
            return false
        case .notDetermined:
            return false
        case .fullAccess:
            return true
        case .writeOnly:
            return false
        @unknown default:
            return false
        }
    }
    
    func fetchEvents() {
        let calendars = eventStore.calendars(for: .event)
        let startDate = Date(timeIntervalSinceNow: -30*24*3600)
        let endDate = Calendar.current.date(byAdding: .year, value: 1, to: startDate)!
        
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars)
        let events = eventStore.events(matching: predicate)
        DispatchQueue.main.async {
            self.events = events
        }
    }
}
