//
//  ContentView.swift
//  Hydrate
//
//  Created by Fai Alharthi on 18/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
//    @State var BodyWeight: Double = 0.0
    @State var value : String = ""
    @State var BW : String = "Body Weight"
    var body: some View {
        
        NavigationView{

         VStack {
                
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
                
                HStack{
                    
                    ZStack{
                        TextField("Value" , value:$value ,formatter:NumberFormatter())
                            .multilineTextAlignment(.center).padding(.bottom ,20).padding(.leading,60)
                            .keyboardType(.decimalPad)
                            .frame(width:350, height: 49, alignment:.center)
                            .padding(.leading,10).padding(.top,20)
                            .foregroundStyle(.black)
                        Text("Body weight").font(.system(size: 17, weight: .regular))
                            .frame(width:230, alignment: .leading)
                    }
                    
                    
                    Button(action: {
                        value = ""
                    },label: {
                        Image(systemName: "xmark.circle.fill")
                    }).frame(width:20,height:22).padding(.trailing,60).foregroundStyle(Color.myGray)
                    
                    
                }.frame(width: 355,height: 44).background(Color.myFieldsGray).padding(.top,20)
                Spacer()
                
                HStack{
                    NavigationLink(destination:Notifications()){
                        Text("Next")
                    }
                }.frame(width:355,height:50).background(Color.cyan).foregroundStyle(Color.white).cornerRadius(16)
            }.frame(height: 550, alignment: .top).padding(.top,90)
            
            
            
        }
        
    }
}

#Preview {
    ContentView()
}
