//
//  MonteCarloFunc.swift
//  MonteCarlo_ex
//
//  Created by Daksh Patel on 2/4/22.
//

import Foundation
import SwiftUI


class MonteCarloEx: NSObject, ObservableObject {
    
    @MainActor @Published var insideData = [(xPoint: Double, yPoint: Double)]()
    @MainActor @Published var outsideData = [(xPoint: Double, yPoint: Double)]()

    @Published var totalGuesses = 0.0
    @Published var Guesses = 0.0
    
    
    /// calculate the value of the area under the e ^-x curve
    ///
    /// evaluates the integral using monte carlo approach
    
    func calculateEx() async{
        var maxGueses = 0.0
        let boundingBoxCalculator = BoundingBox()
        
        maxGueses = Guesses
        
        
    }
    
    
    func calculateMonteCarloIntegral(leftEndPoint: Double, rightEndPoint:Double, maxGuesses: Double) async -> Double{
        
        
        
        
    }
    
    
}