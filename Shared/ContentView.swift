//
//  ContentView.swift
//  Shared
//
//  Created by Daksh Patel on 2/4/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var guesses = 0.0
    @ObservedObject var monteCarlo = MonteCarloEx()
    
    
    var body: some View {
        HStack{
            
            VStack{
                
                VStack(alignment: .center) {
                    Text("Guesses")
                        .font(.callout)
                        .bold()
                    TextField("# Guesses", value: $monteCarlo.Guesses, format: .number)
                        .padding()
                        .frame(width: 100)
                }
                .padding(.top, 5.0)
                
                VStack(alignment: .center) {
                    Text("Total Guesses: \(monteCarlo.totalGuesses, specifier: "%.0f")")
                        .font(.callout)
                        .bold()
                        .padding()
                }
                
                VStack(alignment: .center) {
                    Text("Bounds")
                        .font(.callout)
                        .bold()
                    TextField("left end point(lower bound)", value: $monteCarlo.leftEndPoint, format: .number)
                        .padding()
                        .frame(width: 100)
                    TextField("right end point(upper bound)", value: $monteCarlo.rightEndPoint, format: .number)
                        .padding()
                        .frame(width: 100)
                }
                
                VStack(alignment: .center) {
                    Text("Integral value: \(monteCarlo.integral, specifier: "%.6f")")
                        .font(.callout)
                        .bold()
                        .padding()
                }
                
                Button("Cycle Calculation"){
                    Task.init{
                        await self.calculateEx()
                    }
                }
                    .padding()
                
                Button("Clear"){
                    self.clear()
                }
                    .padding(.bottom, 5.0)
                
            }
            .padding()
            
        }
    }
    
    func calculateEx() async {
                
        await monteCarlo.calculateEx()
        
    }
    
    func clear(){

        monteCarlo.totalGuesses = 0.0
        monteCarlo.Guesses = 0.0
        monteCarlo.leftEndPoint = 0.0
        monteCarlo.rightEndPoint = 0.0
        monteCarlo.pointsUnderCurve = 0.0
        monteCarlo.integral = 0.0
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
