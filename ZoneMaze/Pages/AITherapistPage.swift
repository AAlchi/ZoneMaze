import SwiftUI

struct AITherapistPage: View {
    @State var message = ""
    @AppStorage("isNavbarShowing") var isNavbarShowing = false
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    Text("AI Therapist")
                        .font(.system(size: 25))
                        .bold()
                        .padding()
                    ScrollView {
                        VStack(alignment: .leading) {
                            
                            VStack {
                                HStack {
                                    HStack {
                                        Text("Hi there! What brings you in today?")
                                        Spacer()
                                    }
                                    .frame(width: geo.size.width * 0.5)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(RoundedRectangle(cornerRadius: 7.0))
                                    Spacer()
                                }.padding(5)
                                
                                HStack {
                                    
                                    Spacer()
                                    HStack {
                                        Text("hi")
                                        Spacer()
                                    }
                                    .frame(width: geo.size.width * 0.5)
                                    .padding(10)
                                    .background(Color.blue.opacity(0.5))
                                    .clipShape(RoundedRectangle(cornerRadius: 7.0))
                                }.padding(5)
                                
                            }
                            .padding(6)
                        }
                    }
                    
                }
            }
            VStack {
                Spacer()
                HStack {
                    TextField("Type Here", text: $message)
                        .padding(8)
                        .bold()
                        .background(Color.gray.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                    Button("\(Image(systemName: "paperplane"))") {
                        //code
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                }
            }
            
            .padding()
        }.onAppear {
            isNavbarShowing = false
        }
    }
}


