//
//  NuritonCalculator.swift
//  FitApp
//
//  Created by Jakub Malczyk on 19/03/2022.
//

import Foundation

class NuritonCalculator{
    
    func calculateNuritons(male : Bool, sportActivity : Int, weight : Int, height : Int, age: Int, purpose : Int) -> (Int, Int, Int, Int){
        
        var calories : Double
        var protein : Double
        var carbs : Double
        var fats : Double
        
        calories = (9.99 * Double(weight)) + (6.25 * Double(height)) - (4.92 * Double(age))
        
        if male{
            calories = calories + 5
        } else {
            calories = calories - 161
        }
        
        switch sportActivity{
        case 1: calories *= 1.2
        case 2: calories *= 1.4
        case 3: calories *= 1.6
        case 4: calories *= 1.8
        case 5: calories *= 2
        default:
            calories *= 1
        }
        switch purpose{
        case 1: calories -= 400
        case 2: calories *= 1
        case 3: calories += 400
        default:
            calories *= 1
        }
        
        protein = 2 * Double(weight)
        
        fats = calories * 0.25 / 9
        
        carbs = (calories - (protein + fats) ) / 4
    
        return (Int(calories), Int(protein), Int(carbs), Int(fats))
    }
    
    
    
}
