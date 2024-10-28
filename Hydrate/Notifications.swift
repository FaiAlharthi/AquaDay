//
//  Notifications.swift
//  Hydrate
//
//  Created by Fai Alharthi on 19/04/1446 AH.
//

import SwiftUI

struct Notifications: View {
    @Binding var weight: Double
    var p1:person
    @State var Minintervals: [Int] = [15, 30, 60, 90]
    @State var Hourintervals: [Int] = [2, 3, 4, 5]
    @State var isPressed: [Bool] = [false, false, false, false]
    @State var isPressed2: [Bool] = [false, false, false, false]
    @State var StartHour: Date = Date()
    @State var EndHour: Date = Date()

    var body: some View {
        NavigationView {
            VStack {
                Text("Notification Preferences")
                    .font(.system(size: 22, weight: .bold))
                    .frame(width: 360, alignment: .leading)
                
                Text("The start and End hour")
                    .font(.system(size: 17, weight: .semibold))
                    .frame(width: 360, alignment: .leading)
                    .padding(.top, 17)
                
                Text("Specify the start and end date to receive the notifications")
                    .font(.system(size: 16))
                    .frame(width: 360, alignment: .leading)
                    .padding(.top, 1)
                
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(height: 44)
                            .foregroundStyle(Color.myFieldsGray)
                        
                        Text("Start Hour")
                            .frame(width: 330, alignment: .leading)
                            .padding(.top)
                        
                        DatePicker("", selection: $StartHour, displayedComponents: .hourAndMinute)
                            .frame(width: 320)
                            .padding(.top, 20)
                    }
                    Divider()
                    ZStack {
                        Rectangle()
                            .frame(height: 44)
                            .foregroundStyle(Color.myFieldsGray)
                        
                        Text("End Hour")
                            .frame(width: 330, alignment: .leading)
                            .padding(.bottom)
                        
                        DatePicker("", selection: $EndHour, displayedComponents: .hourAndMinute)
                            .frame(width: 320)
                            .padding(.bottom, 20)
                    }
                }
                .frame(height: 110)
                .background(Color.myFieldsGray)
                .padding(.top, 20)
                
                Text("Notification interval")
                    .font(.system(size: 17, weight: .bold))
                    .frame(width: 360, alignment: .leading)
                    .padding(.top, 30)
                
                Text("How often would you like to receive notifications within the specified time interval")
                    .font(.system(size: 16))
                    .frame(width: 360, alignment: .leading)
                    .padding(.top, 1)
                
                VStack {
                    HStack(spacing: 12) {
                        ForEach(Minintervals.indices, id: \.self) { index in
                            Button(action: {
                                isPressed[index].toggle()
                            }) {
                                VStack {
                                    Text("\(Minintervals[index])")
                                        .foregroundColor(isPressed[index] ? Color.white : Color.cyan)
                                    Text("Mins")
                                        .foregroundColor(isPressed[index] ? Color.white : Color.black)
                                }.frame(width: 77, height: 70)
                            }
                            .background(isPressed[index] ? Color.cyan : Color.myFieldsGray)
                            .cornerRadius(12)
                        }
                    }.frame(width: 360)
                    
                    HStack(spacing: 12) {
                        ForEach(Hourintervals.indices, id: \.self) { index in
                            Button(action: {
                                isPressed2[index].toggle()
                            }) {
                                VStack {
                                    Text("\(Hourintervals[index])")
                                        .foregroundColor(isPressed2[index] ? Color.white : Color.cyan)
                                    Text("Hours")
                                        .foregroundColor(isPressed2[index] ? Color.white : Color.black)
                                }.frame(width: 77, height: 70)
                            }
                            .background(isPressed2[index] ? Color.cyan : Color.myFieldsGray)
                            .cornerRadius(12)
                        }
                    }.frame(width: 360)
                }
                .padding(.top, 10)
                
                Spacer()
                
                HStack {
                    NavigationLink(destination: LitersCounting(weight: $weight,p1: p1)) {
                        Text("Start")
                    }
                }
                .frame(width: 355, height: 50)
                .background(Color.cyan)
                .foregroundStyle(Color.white)
                .cornerRadius(16)
                .padding(.top, 40)
            }
            .frame(width: 360, height: 650)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Notifications(weight: .constant(70),p1: person())
}
