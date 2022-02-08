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
    @Published var leftEndPoint = 0.0
    @Published var rightEndPoint = 0.0
    @Published var pointsUnderCurve = 0.0
    @Published var integral = 0.0
    
    /// calculate the value of the area under the e ^-x curve
    ///
    /// evaluates the integral using monte carlo approach
    
    func calculateEx() async{
        let boundingBoxCalculator = BoundingBox()
        
        let newValue = await calculateMonteCarloIntegral(leftEndPoint: leftEndPoint, rightEndPoint: rightEndPoint, maxGuesses: Guesses)
        
       let insidePoints = pointsUnderCurve + newValue
       let totalPoints = totalGuesses + Guesses
        
       let integralVal = (insidePoints/totalPoints) * boundingBoxCalculator.calculateSurfaceArea(numberOfSides: 2, lengthOfSide1: 2.0, lengthOfSide2: (rightEndPoint - leftEndPoint), lengthOfSide3: 0.0)
        
        await updatePointsUnderCurve(pointsUnderCurve: insidePoints)
        await updateTotalGuesses(totalGuesses: totalPoints)
        await updateIntegral(integral: integralVal)
        
    }
    
    
    func calculateMonteCarloIntegral(leftEndPoint: Double, rightEndPoint:Double, maxGuesses: Double) async -> Double{
        
        var numberOfGuesses = 0.0
        var pointsInRadius = 0.0
        var point = (xPoint: 0.0, yPoint: 0.0)
        
        /// exPoint is the y value of e-x for a given x value
        var exPoint = 0.0
        
        var newInsidePoints : [(xPoint: Double, yPoint: Double)] = []
        var newOutsidePoints : [(xPoint: Double, yPoint: Double)] = []
        
        while numberOfGuesses < maxGuesses {
            
            /* Calculate 2 random values within the box */
            /* Determine the distance from that point to the origin */
            /* If the distance is less than the unit radius count the point being within the Unit Circle */
            point.xPoint = Double.random(in: -leftEndPoint...rightEndPoint)
            point.yPoint = Double.random(in: 0.0...2.0)
            
            exPoint = exp(-point.xPoint)
            
            if((exPoint - point.yPoint) >= 0.0){
                pointsInRadius += 1.0
                newInsidePoints.append(point)
                
            }
            else {
                newOutsidePoints.append(point)
            }
            
            numberOfGuesses += 1.0
        
        }
        
        return pointsInRadius
    }
    
    @MainActor func updatePointsUnderCurve(pointsUnderCurve: Double){
        self.pointsUnderCurve = pointsUnderCurve
    }
    
    @MainActor func updateTotalGuesses(totalGuesses: Double){
        self.totalGuesses = totalGuesses
    }
    
    @MainActor func updateIntegral(integral: Double){
        self.integral = integral
    }
    
    
}
