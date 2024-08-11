import SwiftUI
import UserNotifications
import UserNotificationsUI
import MapKit

struct WeeklySchedulesPage: View {
    
    
    @ObservedObject var calendarManager = CalendarManager_Apple()
    @State var isCalendarAccessGranted = false
    @State var isCalendarAlertPresented = false
    @State var searchInput = ""
    @AppStorage("theme") var theme = "orange"
    @State var coordinatesMap: CLLocationCoordinate2D?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .center) {
                        Text("Calendar")
                            .bold()
                            .font(.system(size: 23))
                        Spacer()
                    }
                    
                    VStack {
                        if !isCalendarAccessGranted {
                            Button("Connect to Apple Calendar") {
                                calendarManager.requestAccess { granted in
                                    if granted {
                                        calendarManager.fetchEvents()
                                        isCalendarAccessGranted = true
                                    } else {
                                        isCalendarAlertPresented = true
                                    }
                                }
                            }
                        }
                    }
                    .alert(isPresented: $isCalendarAlertPresented) {
                        Alert(title: Text("Something went wrong"), message: Text("To get access to Apple Calendar, go to Settings --> Apps --> ZoneMaze --> and turn on the Calendar option"), primaryButton: .cancel(), secondaryButton: .default(Text("Go to Settings"), action: {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }))
                    }
                }
                .padding()
                ScrollView {
                    VStack(alignment: .leading) {
                        NavigationLink(destination: DailySchedulesPage(weekday: .constant(calendarManager.formatTheDate(arg: Date(), type: "weekday")))) {
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Text("Today's Date")
                                        .font(.title)
                                        .bold()
                                    Text(calendarManager.formatTheDate(arg: Date(), type: "weekday"))
                                        .font(.title2)
                                }
                                VStack(alignment: .leading, spacing: -3) {
                                    
                                    if let event = calendarManager.events.first(where: {calendarManager.formatTheDate(arg: $0.startDate, type: "weekday") == calendarManager.formatTheDate(arg: Date(), type: "weekday") && calendarManager.determineDate(date: $0.startDate)} )
                                    {
                                        HStack {
                                            Text("Next up")
                                                .font(.title3)
                                                .bold()
                                                .padding(.bottom)
                                                .padding(.top)
                                            Spacer()
                                            VStack {
                                                Text(event.title ?? "No title")
                                                    .font(.headline)
                                                    .padding(.horizontal)
                                                    .padding(.top)
                                                    .padding(.bottom)
                                            }
                                            .background(.white)
                                            .clipShape(.rect(
                                                topLeadingRadius: 10,
                                                bottomLeadingRadius: 0,
                                                bottomTrailingRadius: 0,
                                                topTrailingRadius: 10
                                            ))
                                        }
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text(calendarManager.formatTheDate(arg: event.startDate, type: "time"))
                                                    .font(.headline)
                                                Spacer()
                                                Text(event.startDate, style: .date)
                                                    .font(.subheadline)
                                            }
                                            if let mapCoordinate = coordinatesMap {
                                                Map(coordinates: mapCoordinate)
                                                    .frame(minHeight: 200)
                                                Text(event.location ?? "N/A")
                                            } else {
                                                Text("No location")
                                            }
                                        }
                                        .padding()
                                        .background(.white)
                                        .clipShape(.rect(
                                            topLeadingRadius: 10,
                                            bottomLeadingRadius: 10,
                                            bottomTrailingRadius: 10,
                                            topTrailingRadius: 0
                                        ))
                                        .multilineTextAlignment(.leading)
                                        .onAppear() {
                                            if let e = event.location {
                                                getCoordinates(from: e) { c in
                                                    self.coordinatesMap = c
                                                }
                                            }
                                        }
                                    } else {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("Nothing")
                                                    .font(.headline)
                                                Spacer()
                                            }
                                            Text("Your schedule is empty for today")
                                        }
                                        .padding()
                                        .background(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                    }
                                }
                            }
                            .padding()
                            .padding(.vertical)
                        }
                        .frame(minHeight: 350)
                        .foregroundStyle(Color.black)
                        .background(Color[theme].opacity(0.5).gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        
                        Text("The rest of the week")
                            .bold()
                            .font(.title2)
                            .padding(.vertical)
                        
                        NavigationLink(destination: DailySchedulesPage(weekday: .constant("Monday"))) {
                            HStack {
                                Text("Monday")
                                    .padding(.vertical, 5)
                                    .font(.title2)
                                Spacer()
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        }
                        NavigationLink(destination: DailySchedulesPage(weekday: .constant("Tuesday"))) {
                            HStack {
                                Text("Tuesday")
                                    .padding(.vertical, 5)
                                    .font(.title2)
                                Spacer()
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        }
                        NavigationLink(destination: DailySchedulesPage(weekday: .constant("Wednesday"))) {
                            HStack {
                                Text("Wednesday")
                                    .padding(.vertical, 5)
                                    .font(.title2)
                                Spacer()
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        }
                        NavigationLink(destination: DailySchedulesPage(weekday: .constant("Thursday"))) {
                            HStack {
                                Text("Thursday")
                                    .padding(.vertical, 5)
                                    .font(.title2)
                                Spacer()
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        }
                        NavigationLink(destination: DailySchedulesPage(weekday: .constant("Friday"))) {
                            HStack {
                                Text("Friday")
                                    .padding(.vertical, 5)
                                    .font(.title2)
                                Spacer()
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        }
                        NavigationLink(destination: DailySchedulesPage(weekday: .constant("Saturday"))) {
                            HStack {
                                Text("Saturday")
                                    .padding(.vertical, 5)
                                    .font(.title2)
                                Spacer()
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        }
                    }
                    .listStyle(PlainListStyle())
                    .padding()
                }
            }
            .onAppear() {
                if calendarManager.checkValidation() {
                    isCalendarAccessGranted = true
                    calendarManager.fetchEvents()
                }
            }
        }
        
    }
}
