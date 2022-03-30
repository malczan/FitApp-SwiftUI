//
//  DiaramView.swift
//  FitApp
//
//  Created by Jakub Malczyk on 18/03/2022.
//

import SwiftUI

struct DiagramView: View {
    
    @EnvironmentObject var nuritionVM : NuritionViewModel
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: -40){
             
                HStack(spacing: -40){
                        
                    ProgressBar(color: Color.orange, nuriton: "KCAL", demand: nuritionVM.nuritonDemand.kcal, actual: nuritionVM.nuritonProvide.kcal)
                        .frame(width: 160, height: 160)
                        .padding(40)
                            
                    ProgressBar(color: Color.red, nuriton: "PROTEIN", demand: nuritionVM.nuritonDemand.proteins, actual: nuritionVM.nuritonProvide.proteins)
                        .frame(width: 160, height: 160)
                        .padding(40)
                }
                HStack(spacing: -40){
                    ProgressBar(color: Color.blue, nuriton: "CARBS",demand: nuritionVM.nuritonDemand.carbs, actual: nuritionVM.nuritonProvide.carbs)
                        .frame(width: 160, height: 160)
                        .padding(40)
                        
                    
                    ProgressBar(color: Color.green, nuriton: "FATS", demand: nuritionVM.nuritonDemand.fats, actual: nuritionVM.nuritonProvide.fats)
                        .frame(width: 160, height: 160)
                        .padding(40)
                            
                }
                    
            }// : VStack
            .navigationTitle("Nurition Diagrams")
            
        }// : NavigationView
    }
}

struct ProgressBar: View {
    
    
    @EnvironmentObject var nuritionVM : NuritionViewModel

    var color : Color
    var nuriton : String
    var demand : Int
    var actual : Int
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(color)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(Float(actual)/Float(demand), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: 1)
            VStack {
                Text(nuriton)
                    .font(.system(size: 24, weight: .medium))
                HStack{
                    Text("\(String(actual))/\(String(demand))")
                    Text(nuriton=="KCAL" ? "" : "G")
                }.font(.system(size: 18, weight: .light))
            }
        }
    }
    
}

struct DiaramView_Previews: PreviewProvider {
    static var previews: some View {
        DiagramView()
            .environmentObject(NuritionViewModel())
    }
}
