//
//  ContentView.swift
//  Hydrate
//
//  Created by Fai Alharthi on 18/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State var BodyWeight: Double = 0.0
    @State var value : String = ""
    @State var BW : String = "Body Weight"
    var body: some View {
        
        func convertToDouble( BD: String) -> Double {
            let Bodyweight = Double(BD) ?? 0.0
            return Bodyweight
        }
        return VStack {
            Image(systemName: "drop.fill")
                .foregroundColor(.cyan)
                .font(Font.system(size:56))
                .fontWeight(.semibold)
                .frame(width:330, alignment:.leading)
                .padding(.bottom,4)
            
                Text("Hydrate")
                    .font(.system(size:22, weight: .semibold))
                    .padding(.bottom,20)
                    .frame(width:330, alignment:.leading)
                    
                Text("Start with Hydrate to record and track your water intake daily based on your needs and stay hydrated")
                .font(.system(size: 17, weight: .regular)).foregroundStyle(.myGray)
                    .frame(width:330)
            
            
            TextField("Body Weight", value:$BodyWeight ,formatter:NumberFormatter())
                .keyboardType(.decimalPad)
                .frame(width:350, height: 49, alignment:.trailing)
                .background(Color.myFieldsGray)
                .padding(.leading,10).padding(.top,20)
                .foregroundStyle(.black)
        }.padding(.bottom,400).padding(.trailing,30)
    }
}

#Preview {
    ContentView()
}
