//
//  MealsView.swift
//  FitApp
//
//  Created by Jakub Malczyk on 19/03/2022.
//

import SwiftUI

struct MealsView: View {
    
    @EnvironmentObject var nuritionVM : NuritionViewModel
    @State var addMeal = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(nuritionVM.dailyMeals) {meals in
                    Section(header: Text("\(meals.name)")) {
                        ForEach(meals.dish) {dish in
                            HStack{
                                Text(dish.tittle)
                                    .font(.system(size: 20, weight: .light))
                                
                                Spacer()
                                
                                Text("\(dish.kcal)kcal")
                                    .font(.system(size: 20, weight: .light))
                            }
                            .frame(height: 40)
                            .swipeActions() {
                                Button(role: .destructive) {
                                    nuritionVM.deleteDish(meal: meals, dish: dish)
                                } label: {
                                    Label("Delete", systemImage: "trash.circle")
                                }
                            }// meal
                            
                        }// dish
                        
                    }
                    
                }
            }// : List
            .navigationBarTitle("Your meals")
            .navigationBarItems(trailing: Button(action: {
                addMeal.toggle()
            }, label: {
                Image(systemName: "text.badge.plus")
            }))
        }
        .fullScreenCover(isPresented: $addMeal) {
            AddMeal(addMeal: $addMeal)
                .environmentObject(nuritionVM)
        }
    }
    
}

struct AddMeal : View{
    
    @EnvironmentObject var nuritionVM : NuritionViewModel
    @Binding var addMeal : Bool
    
    @State var tittle : String = ""
    @State var meal : Int = 0
    @State var kcal : Int = 0
    @State var proteins : String = ""
    @State var carbs : String = ""
    @State var fats : String = ""
    
    var body : some View{
        NavigationView{
            Form{
                TextField("Meal tittle", text: $tittle)
                Picker(selection: $meal
                       , label: Text("Meal")) {
                    Text("Breakfast")
                        .tag(0)
                    Text("Lunch")
                        .tag(1)
                    Text("Dinner")
                        .tag(2)
                    Text("Snack")
                        .tag(3)
                    Text("Supper")
                        .tag(4)
                }
                TextField("Proteins (g)", text: $proteins)
                    .keyboardType(.numberPad)
                TextField("Carbohydrates (g)", text: $carbs)
                    .keyboardType(.numberPad)
                TextField("Fats (g)", text: $fats)
                    .keyboardType(.numberPad)
            }// : Form
            .navigationTitle("Meal details")
            .navigationBarItems(leading: Button(action: {
                addMeal.toggle()
            }, label: {
                Text("Cancel")
            }))
            .navigationBarItems(trailing: Button(action: {
                nuritionVM.addDish(tittle: tittle, category: meal, proteins: Int(proteins) ?? 0, carbs: Int(carbs) ?? 0, fats: Int(fats) ?? 0)
                addMeal.toggle()
            }, label: {
                Image(systemName: "text.badge.checkmark")
            }))
        }//
    }
}


struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        MealsView()
            .environmentObject(NuritionViewModel())
    }
}
