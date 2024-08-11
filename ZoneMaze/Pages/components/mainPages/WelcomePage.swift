import SwiftUI

struct WelcomePage: View {
    @Binding var theme: String
    @Binding var isLoggedIn: Bool
    @Binding var isNavbarShowing: Bool
    
    @State var username = ""
    @State var password = ""
    @State var readMore = false
    @State var whichImage = "MainPageImage"
    @State var whichImageNumber = 0
    
    var body: some View {
        GeometryReader { geometry in
            
            NavigationStack {
                ZStack {
                    Image("\(whichImage)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.35)
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("ZoneMaze")
                                .bold()
                                .font(.system(size:  30))
                            Text("Make life simpler.")
                                .font(.system(size: 15))
                        }
                        .padding(.top, 50)
                        Spacer()
                        VStack(alignment: .center) {
                            Spacer()
                            HStack {
                                if whichImageNumber == 0 {
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundStyle(Color[theme])
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundStyle(Color.black.opacity(0.2))
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundStyle(Color.black.opacity(0.2))
                                } else if whichImageNumber == 1 {
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundStyle(Color.black.opacity(0.2))
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundStyle(Color[theme])
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundStyle(Color.black.opacity(0.2))
                                } else {
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundStyle(Color.black.opacity(0.2))
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundStyle(Color.black.opacity(0.2))
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundStyle(Color[theme])
                                }
                            }
                            .frame(width: geometry.size.width * 0.77)
                            .padding(.bottom)
                            NavigationLink(destination: SetupScreen()) {
                                Text("Continue")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color[theme])
                                    .foregroundStyle(.white)
                                    .bold()
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            }
                            .padding(.bottom, 20) 
                        }.frame(width: geometry.size.width * 0.77)
                    }
                    Spacer()
                }
            } 
            .onAppear {
                isNavbarShowing = false
                
                Timer.scheduledTimer(withTimeInterval: 2,  repeats: true) { timer in
                    withAnimation {
                        if whichImage == "MainPageImage" {
                            withAnimation {
                                whichImage = "work2"
                                whichImageNumber = 1
                            }
                        } else if whichImage == "work2" {
                            withAnimation {
                                whichImage = "work3"
                                whichImageNumber = 2
                            }
                        } else if whichImage == "work3" {
                            withAnimation {
                                whichImage = "MainPageImage"
                                whichImageNumber = 0
                            }
                        }
                    }
                }
            }
            
        }
        
    }
}
