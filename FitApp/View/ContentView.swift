//
//  ContentView.swift
//  FitApp
//
//  Created by Jakub Malczyk on 18/03/2022.
//


import SwiftUI

struct ContentView: View {
    
    
    @StateObject var nuritionVM = NuritionViewModel()
    @AppStorage ("firstLaunch") var firstLaunch = true

    var body: some View {
        TabView{
            MealsView()
                .tabItem {
                    Label("Meals", systemImage: "fork.knife")
                }
            
            DiagramView()
                .tabItem {
                    Label("Diagrams", systemImage: "heart.text.square.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }// : TabView
        .environmentObject(nuritionVM)
        .fullScreenCover(isPresented: $firstLaunch) {
            PersonalSettings()
                .environmentObject(nuritionVM)
                
        }
        .onAppear{
            nuritionVM.updateAllData()
            nuritionVM.checkDate()
        }
    }
}

struct PersonalSettings : View{
    
    @EnvironmentObject var nuritionVM : NuritionViewModel
    @AppStorage ("firstLaunch") var firstLaunch = true
    
    var body: some View{
        VStack{
            
            Text("Complete your body information")
        }.multilineTextAlignment(.center)
            .font(.system(size: 22, weight: .light))
            .padding(.top, 40)
        
        Spacer()
        
        VStack{
            
            Spacer()
            
            VStack(spacing: 60){
                VStack (spacing: 10){
                    Text("Gender")
                        .font(.system(size: 18, weight: .light))
                    Picker(selection: $nuritionVM.personDetails.male
                           , label: Text("Picker here")) {
                        Text("Male")
                            .tag(true)
                        Text("Female")
                            .tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 280, height: 20)
                }
                VStack(spacing: 8){
                    Text("Your weight purpose")
                        .font(.system(size: 18, weight: .light))
                    Picker(selection: $nuritionVM.personDetails.purpose, label: Text("Purpose")){
                        Text("Loss")
                            .tag(1)
                        Text("Keep")
                            .tag(2)
                        Text("Gain")
                            .tag(3)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 280, height: 20)
                
                VStack(spacing: 8){
                    Text("Sport activity")
                        .font(.system(size: 18, weight: .light))
                        .multilineTextAlignment(.center)
                        .lineLimit(0)
                    Picker(selection: $nuritionVM.personDetails.activity, label: Text("Sport")){
                        Text("1")
                            .tag(1)
                        Text("2")
                            .tag(2)
                        Text("3")
                            .tag(3)
                        Text("4")
                            .tag(4)
                        Text("5")
                            .tag(5)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 280, height: 20)
            } // VStack gender, purpose and activity
            
            Spacer()
           
            VStack(spacing: 30){
                VStack{
                    Text("Age: \(String(format: "%.0f", nuritionVM.personDetails.age))")
                        .font(.system(size: 18, weight: .light))
                    Slider(value: $nuritionVM.personDetails.age, in: 1...100, step: 1)
                        .frame(width: 280, height: 20)
                }
                
                VStack{
                    Text("Weight: \(String(format: "%.0f", nuritionVM.personDetails.weight))kg")
                        .font(.system(size: 18, weight: .light))
                    Slider(value: $nuritionVM.personDetails.weight, in: 1...200, step: 1)
                        .frame(width: 280, height: 20)
                }
                
                VStack {
                    Text("Height: \(String(format: "%.0f", nuritionVM.personDetails.height))cm")
                        .font(.system(size: 18, weight: .light))
                    Slider(value: $nuritionVM.personDetails.height, in: 1...200, step: 1)
                        .frame(width: 280, height: 20)
                }
            } // VStack age, weight and height
            
            Spacer()
            
            Text("You can change these settings later")
                .font(.system(size: 18, weight: .light))
                .padding(.horizontal)
    
            Button{
                nuritionVM.calculateNuritionDemand()
                firstLaunch.toggle()
                
            } label: {
                Text("SAVE INFORMATIONS")
            }
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(25)
            
            Spacer()

        }// : VStack // All stuff
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NuritionViewModel())
    }
}

