//
//  ScheduleTemplates.swift
//  ZoneMaze
//
//  Created by Ali AI on 1/6/24.
//

import SwiftUI
import UserNotifications
import UserNotificationsUI
import MapKit

struct DailySchedulesPage: View {
    @Binding var weekday: String
    @State var coordinatesMap: CLLocationCoordinate2D?
    @ObservedObject var calendarManager = CalendarManager_Apple()

    var body: some View {
        VStack {
            Text(weekday)
            List(calendarManager.events, id: \.eventIdentifier) { event in
                if (calendarManager.formatTheDate(arg: event.startDate, type: "weekday") == weekday) && calendarManager.determineDate(date: event.startDate) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(event.title ?? "No title")
                                .font(.headline)
                            Spacer()
                            Text(calendarManager.formatTheDate(arg: event.startDate, type: "time"))
                        }
                        Text(event.startDate, style: .date)
                            .font(.subheadline)
                        if let mapCoordinate = coordinatesMap {
                            Map(coordinates: mapCoordinate)
                                .frame(minHeight: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                            Text(event.location ?? "N/A")
                                .padding(.vertical)
                        } else {
                            Text("No location")
                        }
                    }
                    .onAppear() {
                        if let e = event.location {
                            getCoordinates(from: e) { c in
                                self.coordinatesMap = c
                            }
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding()
        .onAppear() {
            if calendarManager.checkValidation() {
                calendarManager.fetchEvents()
            }
        }
    }
}

