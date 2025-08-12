//
//  ContentView.swift
//  Hydrate
//
//  Created by Fai Alharthi on 18/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State var value: String = ""
    @State var weight: Double = 0.0
    @State var p1: person = person()
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "drop.fill")
                    .foregroundColor(.cyan)
                    .font(Font.system(size: 56))
                    .fontWeight(.semibold)
                    .frame(width: 330, alignment: .leading)
                    .padding(.bottom, 4)
                
                Text("Hydrate")
                    .font(.system(size: 22, weight: .semibold))
                    .padding(.bottom, 20)
                    .frame(width: 330, alignment: .leading)
                
                Text("Start with Hydrate to record and track your water intake daily based on your needs and stay hydrated")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.myGray)
                    .frame(width: 330)
                
                HStack {
                    
                    ZStack(alignment: .leading) {
                        

                            
                        Text("Body weight")
                            .font(.system(size: 17, weight: .regular)).frame(width: 95)

                        TextField("Value", text: $value)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 250, height: 49).padding(.leading,20)
                        
                        
                        Button(action: {
                            value = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                        }
                        .frame(width: 20, height: 22)
                        .padding(.leading, 300)
                        .foregroundStyle(Color.myGray)
                        
                        
 
                        
                    }
                    

                    
                }.frame(width: 355, height: 44)
                .background(Color.myFieldsGray)
                .padding(.top, 20)
                
                Spacer()
                
                HStack {
                    
                    NavigationLink(destination: Notifications(weight: $weight, p1: p1)) {
                        Text("Start")
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        weight = Double(value) ?? 0
                        p1.weight = weight
                    })
                }.frame(width: 355, height: 50)
                .background(Color.cyan)
                .foregroundStyle(Color.white)
                .cornerRadius(16)
            }
            .frame(height: 550, alignment: .top)
            .padding(.top, 90)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
