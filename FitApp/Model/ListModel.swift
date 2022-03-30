//
//  ListModel.swift
//  FitApp
//
//  Created by Jakub Malczyk on 20/03/2022.
//

import Foundation


struct Meals : Identifiable, Codable{
    
    var id = UUID()
    let name : String
    var dish : [Dish]
}

struct Dish : Identifiable, Codable{
   
    var id = UUID()
    var tittle : String
    var kcal : Int
    var proteins : Int
    var carbs : Int
    var fats : Int
    
}


