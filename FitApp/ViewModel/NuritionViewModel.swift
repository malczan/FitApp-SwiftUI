//
//  NuritionViewModel.swift
//  FitApp
//
//  Created by Jakub Malczyk on 19/03/2022.
//

import Foundation
import SwiftUI

class NuritionViewModel : ObservableObject{
    
    var calculator = NuritonCalculator()
    
    @Published var personDetails : PersonModel {
        didSet {
            saveSettings()
        }
    }
    
    @Published var nuritonProvide : NuritonProvide{
        didSet {
            saveNuritionProvide()
        }
    }
    @Published var nuritonDemand : NuritonDemand{
        didSet {
            saveNuritionDemand()
        }
    }
    
    @Published var dailyMeals : [Meals]{
        didSet{
            saveMeals()
        }
    }
    
    let personKey : String = "person_details"
    let mealsKey : String = "meals_key"
    let provideKey : String = "provide_key"
    let demandKey : String = "demand_key"
    
    init(){
        self.nuritonDemand = NuritonDemand(kcal: 0, proteins: 0, carbs:0, fats: 0)
        self.nuritonProvide = NuritonProvide(kcal: 0, proteins: 0, carbs: 0, fats: 0)
        self.dailyMeals = [
                           Meals(name: "Breakfast", dish: []),
                           Meals(name: "Lunch", dish: []),
                           Meals(name: "Dinner", dish: []),
                           Meals(name: "Snack", dish: []),
                           Meals(name: "Supper", dish: [])
                                                            ]
        self.personDetails = PersonModel(age: 50, weight: 100, height: 100, male: true, purpose: 3, activity: 3)
    }
    
    
    
    func calculateNuritionDemand(){
        let nuritions = calculator.calculateNuritons(
            male: personDetails.male,
            sportActivity: personDetails.activity,
            weight: Int(personDetails.weight),
            height: Int(personDetails.height),
            age: Int(personDetails.age),
            purpose: personDetails.purpose
        )
        
        
        nuritonDemand.kcal = nuritions.0
        nuritonDemand.proteins = nuritions.1
        nuritonDemand.carbs = nuritions.2
        nuritonDemand.fats = nuritions.3
    }
    
    func addDish(tittle : String, category : Int, proteins : Int, carbs : Int, fats : Int){
        
        let calories = (proteins * 4) + (carbs * 4) + (fats * 9)
        nuritonProvide.kcal += calories
        nuritonProvide.proteins += proteins
        nuritonProvide.carbs += carbs
        nuritonProvide.fats += fats
        
        dailyMeals[category].dish.append(Dish(tittle: tittle, kcal: calories, proteins: proteins, carbs: carbs, fats: fats))
    }
    
    func deleteDish(meal : Meals, dish : Dish){
        
        if let i = dailyMeals.firstIndex(where: { $0.name == meal.name}){
            if let j = dailyMeals[i].dish.firstIndex(where: {$0.tittle == dish.tittle && $0.kcal == dish.kcal}){
                
                nuritonProvide.kcal -= dailyMeals[i].dish[j].kcal
                nuritonProvide.proteins -= dailyMeals[i].dish[j].proteins
                nuritonProvide.carbs -= dailyMeals[i].dish[j].carbs
                nuritonProvide.fats -= dailyMeals[i].dish[j].fats
                dailyMeals[i].dish.remove(at: j)
               
            }
        }
        
    }
    
    
    // : MARK: SAVING AND LOADING DATA BY USERDEFAULTS
    
    private func saveSettings(){
        if let data = try? JSONEncoder().encode(personDetails){
            UserDefaults.standard.set(data, forKey: personKey)
        }
    }
    
    private func saveMeals(){
        if let data = try? JSONEncoder().encode(dailyMeals){
            UserDefaults.standard.set(data, forKey: mealsKey)
        }
    }
    
    private func saveNuritionDemand() {
        if let data = try? JSONEncoder().encode(nuritonDemand){
            UserDefaults.standard.set(data, forKey: demandKey)
        }
    }
    
    private func saveNuritionProvide(){
        if let data = try? JSONEncoder().encode(nuritonProvide){
            UserDefaults.standard.set(data, forKey: provideKey)
        }
    }
    
    func updateAllData(){
        guard
            let personData = UserDefaults.standard.data(forKey: personKey),
            let savedPersonData = try? JSONDecoder().decode(PersonModel.self, from: personData)

        else { return }
        
        self.personDetails = savedPersonData
        
        guard
            let mealsData = UserDefaults.standard.data(forKey: mealsKey),
            let savedMeals = try? JSONDecoder().decode([Meals].self, from: mealsData)
        else { return }
        
        self.dailyMeals = savedMeals
        
        guard
            let demandData = UserDefaults.standard.data(forKey: demandKey),
            let savedDemand = try? JSONDecoder().decode(NuritonDemand.self, from: demandData)
        else { return }
        
        self.nuritonDemand = savedDemand
        
        guard
            let provideData = UserDefaults.standard.data(forKey: provideKey),
            let savedProvide = try? JSONDecoder().decode(NuritonProvide.self, from: provideData)
        else { return }
        
        self.nuritonProvide = savedProvide
      
    }
    
    // MARK: DATE
    
  func checkDate(){

        
        if UserDefaults.standard.object(forKey: "tomorrow") != nil{
            
            if Date.now.get(.day) == UserDefaults.standard.object(forKey: "tomorrow") as! Int{
               
                
                nuritonProvide.kcal = 0
                nuritonProvide.proteins = 0
                nuritonProvide.carbs = 0
                nuritonProvide.fats = 0
                
                for i in 0..<dailyMeals.count{
                    dailyMeals[i].dish.removeAll()
                }
                
                let tomorrow = Date.now.get(.day) + 1
                UserDefaults.standard.set(tomorrow, forKey: "tomorrow")
            }
        } else {
            let tomorrow = Date.now.get(.day) + 1
            UserDefaults.standard.set(tomorrow, forKey: "tomorrow")
        }
    } 
    
    
    
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}






