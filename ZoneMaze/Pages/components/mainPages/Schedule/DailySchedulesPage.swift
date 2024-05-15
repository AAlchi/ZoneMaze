//
//  ScheduleTemplates.swift
//  ZoneMaze
//
//  Created by Ali AI on 1/6/24.
//

import SwiftUI
import UserNotifications
import UserNotificationsUI


struct DailySchedulesPage: View {  
    @Binding var dayOfTheWeek: String
    @Binding var setUrgentTask: String
    @Binding var isNavbarShowing: Bool
    
    @ObservedObject var items = TheObservedObject()

    @State private var isPopoverOpen = false
    @State private var noteName = ""
    @State private var noteDescription = ""
    @State private var noteAddInfo = ""
    @State private var date = Date.now
    
    func formatTheDate(arg: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.string(from: arg)
        
    }
     
    @AppStorage("theme") var theme = "orange"
    
        var body: some View {
            GeometryReader {geo in
                NavigationStack {
                    VStack {
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                Text("Schedule")
                                    .bold()
                                    .font(.system(size: 23))
                                    .padding(.bottom, 5) 
                            }
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
    
                                Text("Add an Event")
                                    .bold()
                                TextField("Name...", text: $noteName)
                                    .frame(width: geo.size.width * 0.8)
                                    .padding(10)
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                    .background(Color.gray.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerRadius: 5.0))
     
    
    
                                withAnimation {
                                    VStack {
                                        DatePicker("Select a time", selection: $date, displayedComponents: .hourAndMinute)
                                            .labelsHidden()
                                    }
                                    .frame(width: geo.size.width * 0.85, height: 100)
                                }
    
                                Button(action: {
                                    items.scheduleScheduleItem.append(ScheduleScheduleItem(scheduleTitle: noteName, scheduleDate: date, theActualDay: dayOfTheWeek, isScheduled: false))
                                    noteName = ""
                                    noteDescription = ""
                                    isPopoverOpen = false
    
                                }, label: {
                                    Text("Add event")
                                        .frame(width: geo.size.width * 0.85, height: 40)
                                        .foregroundColor(.white)
                                        .background(Color[theme])
                                        .cornerRadius(3.0)
    
                                })
    
                            }
                            .frame(width: geo.size.width * 0.5)
                        }
    
    
                        List {
                            HStack {
                                Text(dayOfTheWeek)
                                    .bold()
                                Spacer()
                            }
    
                            ForEach($items.scheduleScheduleItem, id: \.self) { $item in
                                if item.theActualDay == dayOfTheWeek {
                                    VStack(alignment:  .leading, spacing: 10) {
                                        Text(formatTheDate(arg: item.scheduleDate))
                                            .bold()
                                            .font(.system(size: 23))
                                        Text(item.scheduleTitle)
                                            .font(.system(size: 13))
                                    }
                                    .padding(5)
                                    .swipeActions {
                                        Button("Delete") {
                                            items.scheduleScheduleItem.removeAll(where: { $0.id == item.id }) 
                                        }
                                        .background(Color.red)
                                        .foregroundStyle(Color.white)
                                    }
                                }
                            }
    
    
                        }
                        .listStyle(PlainListStyle())
                    }
                    .onAppear { 
                        isNavbarShowing = true
                    }
                }
            }
        }
}

