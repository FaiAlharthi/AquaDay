//
//  LitersCounting.swift
//  Hydrate
//
//  Created by Fai Alharthi on 19/04/1446 AH.
//

import SwiftUI

struct LitersCounting: View {
    @Binding var weight: Double
    var p1:person
    @State var takenliters: Double = 0.0
    @State var liters: Double = 0.0
    @State var token: String = ""
    var litersText: some View {
        Text("\(takenliters.formatted()) liter")
            .font(.system(size: 22, weight: .bold))
            .frame(width: 100)
            .padding(.top, 2)
            .foregroundStyle(
                takenliters > (liters * 0.75) ? Color.green : Color.primary
            )
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Today's Water Intake:")
                    .frame(width: 360, alignment: .leading)
                    .font(.system(size: 16))
                    .foregroundStyle(.myGray)
                    .padding(.top, 50)
                
                HStack(spacing:0){
                    litersText
                    Text("/ \(liters.formatted()) liter")
                        .font(.system(size: 22, weight: .bold)).frame(width: 120,alignment: .leading)
                        .padding(.top, 2).padding(.trailing, 200)
                 
                }.padding(.leading, 33)
                
                
                ZStack {
                    // Base Circle
                    Circle()
                        .stroke(Color.myFieldsGray, lineWidth: 33)
                        .frame(width: 313, height: 313)
                    
                    // Animation Circle
                    Circle()
                        .trim(from: 0.0, to: CGFloat(takenliters) / CGFloat(liters))
                        .stroke(Color.cyan, style: StrokeStyle(lineWidth: 33, lineCap: .round))
                        .frame(width: 313, height: 313)
                        .rotationEffect(.init(degrees: -90))
                        .animation(.easeInOut(duration: 1), value: takenliters)
                    
                    if takenliters == 0 {
                        Image(systemName: "zzz")
                            .foregroundStyle(Color.yellow)
                            .font(.system(size: 76))
                    } else if takenliters <= (liters * 0.5) {
                        Image(systemName: "tortoise.fill")
                            .foregroundStyle(Color.yellow)
                            .font(.system(size: 76))
                    } else if takenliters > (liters * 0.5) && takenliters <= (liters * 0.75) {
                        Image(systemName: "hare.fill")
                            .foregroundStyle(Color.yellow)
                            .font(.system(size: 76))
                    } else {
                        Image(systemName: "hands.clap.fill")
                            .foregroundStyle(Color.yellow)
                            .font(.system(size: 76))
                        
                    }
                }
                .frame(height: 500)
                
                VStack {
                    Text("\(takenliters.formatted()) L")
                        .font(.system(size: 22, weight: .bold))
                    
                    Stepper(value: $takenliters, in: 0...liters, step: 0.5) {
                        Text("\(takenliters.formatted())")
                    }
                    .frame(width: 100, alignment: .center)
                    .padding(.bottom, 100)
                }
                
                Spacer()
            }
            
            .onAppear {
                liters = p1.litersCalc(weightKG: weight)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LitersCounting(weight: .constant(70),p1: person())
}
