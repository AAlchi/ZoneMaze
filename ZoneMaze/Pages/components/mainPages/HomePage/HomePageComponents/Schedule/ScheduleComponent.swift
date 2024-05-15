//
//  ScheduleComponent.swift
//  ZoneMaze
//
//  Created by Ali AI on 12/28/23.
//

import Foundation
import SwiftUI

struct ScheduleComponent: View {
    @Binding var theme: String
    @Binding var currentNav: String
    
    @State var items = TheObservedObject()
    @State private var date = Date.now
    @State var dateFormatter = DateFormatter()
    func getWeekday() -> String {
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    func formatTheDate(arg: Date) -> String {
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: arg)
    }
    
    func getHour(arg: Date) -> String {
        dateFormatter.dateFormat = "h"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: arg)
    }
    
    func getMinute(arg: Date) -> String {
        dateFormatter.dateFormat = "mm"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: arg)
    }
    
    func getAMPM(arg: Date) -> String {
        dateFormatter.dateFormat = "a"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: arg)
    }
     
    @State var found = false
    
    func Loop() -> Array<String> {
        for i in items.scheduleScheduleItem {
            if i.theActualDay == getWeekday() && getHour(arg: i.scheduleDate) >= getHour(arg: Date()) && getMinute(arg: i.scheduleDate) >= getMinute(arg: Date()) {
                return [formatTheDate(arg: i.scheduleDate), " - " + i.scheduleTitle]
            }
        }
        return ["Your schedule for today is empty", ""]
    }
    
    var body: some View {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    HStack(spacing: 3) {
                        Text("Schedule")
                            .font(.system(size: 23))
                            .bold()
                        Text("- Up Next")
                            .font(.system(size: 23))
                    }
                        
                    Spacer() 
                }.padding()
                  
                HStack(spacing: 0) {
                    Text("\(Loop()[0])")
                        .bold()
                    Text("\(Loop()[1])")
                }
                .padding(.leading)
                .padding(.leading)
                .padding(.bottom)
                .font(.system(size: 22))
            } 
    }
}
