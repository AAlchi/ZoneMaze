//
//  Health.swift
//  ZoneMaze
//
//  Created by Ali AI on 12/28/23.
//

import Foundation
import SwiftUI

struct HealthComponent: View {
    @Binding var theme: String
    var body: some View {
        VStack(alignment: .leading) {
                     VStack {
                         HStack(alignment: .center) {
                             Text("Health")
                                 .bold()
                                 .font(.system(size: 23))
                             Spacer()
                         }
                         .padding(.bottom, 5)
                         Text("Health is categorized into three categories. Figure out how you can become healthier with these short quizes.")
                             .font(.system(size: 15))
                             .foregroundStyle(.gray)
                     }
                     .padding()
     
                     VStack(alignment: .leading, spacing: 5) {
                         VStack(alignment: .leading) {
                             VStack(alignment: .leading) {
                                 NavigationLink(destination: PhysicalHealthQuiz()) {
                                     HStack {
                                         Text("Physical Health Quiz")
                                             .bold()
                                         Spacer()
                                         Image(systemName: "arrowshape.right.fill")
                                     }
                                     .padding()
                                 }
     
                             }
                             .frame(maxWidth: .infinity)
                             .padding()
                             .padding(.leading)
                             .padding(.trailing)
                             .background(Color.black.gradient.opacity(0.05))
                             .clipShape(RoundedRectangle(cornerRadius: 3.0))
                             VStack(alignment: .leading) {
                                 VStack(alignment: .leading) {
                                     NavigationLink(destination: MentalHealthQuiz()) {
                                         HStack {
                                             Text("Mental Health Quiz")
                                                 .bold()
                                             Spacer()
                                             Image(systemName: "arrowshape.right.fill")
                                         }
                                         .padding()
                                     }
     
                                 }
                                 .frame(maxWidth: .infinity)
                                 .padding()
                                 .padding(.leading)
                                 .padding(.trailing)
                                 .background(Color.black.gradient.opacity(0.05))
                                 .clipShape(RoundedRectangle(cornerRadius: 3.0))
                                 VStack(alignment: .leading) {
                                     NavigationLink(destination: SocialHealthQuiz()) {
                                         HStack {
                                             Text("Social Health Quiz")
                                                 .bold()
                                             Spacer()
                                             Image(systemName: "arrowshape.right.fill")
                                         }
                                         .padding()
                                     }
     
                                 }
                                 .frame(maxWidth: .infinity)
                                 .padding()
                                 .padding(.leading)
                                 .padding(.trailing)
                                 .background(Color.black.gradient.opacity(0.05))
                                 .clipShape(RoundedRectangle(cornerRadius: 3.0))
                             }
                         }
                         .padding()
                     }
                     .padding(.bottom)
                 } 
    }
}
 
