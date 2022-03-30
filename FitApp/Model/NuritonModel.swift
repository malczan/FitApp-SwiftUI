//
//  NuritonModel.swift
//  FitApp
//
//  Created by Jakub Malczyk on 19/03/2022.
//

import Foundation

struct NuritonDemand : Codable{
    var kcal : Int
    var proteins : Int
    var carbs : Int
    var fats : Int
    
}

struct NuritonProvide : Codable{
    var kcal : Int
    var proteins : Int
    var carbs : Int
    var fats : Int
    
}
