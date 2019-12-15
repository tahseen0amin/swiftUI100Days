//
//  ContentView.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 14/12/2019.
//  Copyright © 2019 Taazuh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkedAmount = ""
    @State private var numOfPeople = 2
    @State private var tipPercentage = 2
    
    var totalA: Double {
        let tipPercent = Double(self.tipPercentageValue[tipPercentage])
        let orderAmount = Double(checkedAmount) ?? 0.0
        
        let tipAmount = orderAmount / 100 * tipPercent
        return orderAmount + tipAmount
    }
    
    var tipPercentageValue = [0, 10, 15, 20, 25]
    
    var totalAmount : Double {
        let totalPeople = Double(numOfPeople + 2)
        let tipPercent = Double(self.tipPercentageValue[tipPercentage])
        let orderAmount = Double(checkedAmount) ?? 0.0
        
        let tipAmount = orderAmount / 100 * tipPercent
        let total = orderAmount + tipAmount
        
        return total / totalPeople
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Billing Amount", text: $checkedAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of People", selection: $numOfPeople) {
                        ForEach(2 ..< 50) {
                            Text("\($0) people")
                        }
                    }
                
                }
                
                Section(header: Text("How much tips would you like to give")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentageValue.count) {
                            Text("\(self.tipPercentageValue[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total Amount")) {
                    Text("£\(totalA, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount per person")) {
                    Text("£\(totalAmount, specifier: "%.2f")")
                }
            }
        .navigationBarTitle("WeSplit")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
