//
//  Notifications.swift
//  Hydrate
//
//  Created by Fai Alharthi on 19/04/1446 AH.
//

import SwiftUI

struct Notifications: View {
    @State var Minintervals: [Int] = [15, 30, 60, 90]
    @State var Hourintervals: [Int] = [2,3,4,5]
    @State var isPressed: [Bool] = [false, false, false, false]

    var body: some View {
        VStack{
            
            Text("Notification Preferences ")
                .font(.system(size: 22, weight:.bold)).frame(width:360, alignment: .leading).padding(.top,80)
            Text("The start and End hour").font(.system(size: 17,weight:.semibold)).frame(width:360, alignment: .leading).padding(.top, 17)
            Text("Specify the start and end date to receive the notifications ").font(.system(size: 16)).frame(width:360, alignment: .leading).padding(.top,1)
            
            VStack{
                ZStack{
                    Rectangle().frame(height:44).foregroundStyle(Color.myFieldsGray)
                    Text("Start Hour").frame(width:330, alignment:.leading)
                }
                Divider()
                ZStack{
                    Rectangle().frame(height:44).foregroundStyle(Color.myFieldsGray)
                    Text("End Hour").frame(width:330, alignment:.leading)
                }
            }.frame(height:110).background(Color.myFieldsGray).padding(.top,20)
            
            Text("Notification interval ")
                .font(.system(size: 17, weight:.bold)).frame(width:360, alignment: .leading).padding(.top,30)
            
            Text("How often would you like to receive notifications within the specified time interval").font(.system(size: 16)).frame(width:360, alignment: .leading).padding(.top,1)
            
            VStack {
                HStack(spacing: 12) {
                    ForEach(Minintervals, id: \.self) { interval in
                        
                            Button(action: {
                                isPressed[interval].toggle()
                                
                            }){
                                VStack {
                                    Text("\(interval)").foregroundColor(isPressed[interval] ? Color.white : Color.cyan)
                                    Text("Mins").foregroundColor(isPressed[interval] ? Color.white : Color.black)
                                }.frame(width:77, height: 70)
                            }.background(isPressed[interval] ? Color.cyan : Color.myFieldsGray)
                            .cornerRadius(12)
                            


                        
                    }
                }.frame(width:360)
            }

        
            Spacer()
            
        }.frame(width:360, height:750)
    }
}

#Preview {
    Notifications()
}
