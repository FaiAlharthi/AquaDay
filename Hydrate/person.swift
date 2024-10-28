//
//  person.swift
//  Hydrate
//
//  Created by Fai Alharthi on 21/04/1446 AH.
//
import SwiftUI
struct person{
    @State var weight:Double = 0.0
    @State var liters:Double = 0.0
    
    
    func litersCalc (weightKG : Double) -> Double{
        return weightKG * 0.03
        
    }
    

    
   
}
