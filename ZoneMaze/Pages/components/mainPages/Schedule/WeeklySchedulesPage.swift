import SwiftUI
import UserNotifications
import UserNotificationsUI


struct WeeklySchedulesPage: View {
    @Binding var theme: String
    @Binding var currentNav: String
    @Binding var isNavbarShowing: Bool
    @Binding var setUrgentTask: String
    
    @ObservedObject var items = TheObservedObject()
    @State private var selectedWeekday: String = "Monday"
    @State var weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State private var isPopoverOpen = false
    @State private var noteName = ""
    @State private var noteDescription = ""
    @State private var noteAddInfo = ""
    @State var isShouldAppear = true
    @State private var date = Date.now
    
    func formatTheDate(arg: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.string(from: arg)
        
    }
    
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
                            Button("Schedule Templates \(Image(systemName: "arrowshape.right.fill"))") {
                                print("Pressed")
                            }
                            .foregroundStyle(Color[theme].gradient)
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
                            
                            Text("Add a day for your schedule")
                                .bold()
                                .font(.system(size: 27))
                            Text("Create a date for your schedule to happen. You can create the schedule after.")
                                .font(.system(size: 15))
                                .foregroundStyle(Color.gray)
                            VStack {
                                TextField("Name...", text: $noteName)
                                    .frame(width: geo.size.width * 0.90)
                                    .padding(10)
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                    .background(Color.gray.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                    .mask(RoundedRectangle(cornerRadius: 90))
                                
                                withAnimation {
                                    VStack {
                                        Picker("Select Weekday", selection: $selectedWeekday) {
                                            ForEach(weekdays, id: \.self) { weekday in
                                                Text(weekday)
                                            }
                                        }
                                        .pickerStyle(.wheel)
                                    }
                                    .frame(width: geo.size.width * 0.90)
                                }
                                
                                Button(action: {
                                    
                                    items.scheduleItem.append(ScheduleItem(scheduleTitle: noteName, scheduleDate: selectedWeekday))

                                    noteName = ""
                                    noteDescription = ""
                                    isPopoverOpen = false
                                    
                                }, label: {
                                    Text("Add date")
                                        .frame(width: geo.size.width * 0.90, height: 40)
                                        .foregroundColor(.white)
                                        .background(Color[theme])
                                        .cornerRadius(3.0)
                                    
                                })
                            }
                        }
                    }
                    
                    
                    List {
                        HStack {
                            Text("Your Schedules")
                                .bold()
                            Spacer()
                            EditButton()
                                .padding(7)
                                .foregroundStyle(Color.white)
                                .background(Color[theme])
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                        }
                        
                        ForEach($items.scheduleItem, id: \.self) { $item in
                            VStack(alignment:  .leading, spacing: 10) {
                                Text("\(item.scheduleDate)")
                                    .font(.system(size: 23))
                                Text("\(item.scheduleTitle)")
                                    .bold()
                                HStack {
                                    NavigationLink(destination: DailySchedulesPage(dayOfTheWeek: $item.scheduleDate, setUrgentTask: $setUrgentTask, isNavbarShowing: $isNavbarShowing)) {
                                        Text("Create/Edit Schedule")
                                            .foregroundStyle(Color.blue)
                                            .padding(.top)
                                    }
                                }
                                
                                
                            }
                            .padding(5)
                            
                        }
                        .onDelete { indexSet in
                            items.scheduleItem.remove(atOffsets: indexSet)
                        }
                        
                        
                    }
                    .listStyle(PlainListStyle())
                } 
                .onAppear { 
                    isNavbarShowing = true
                    currentNav = "Two"
                }
            }
        }
    }
}
