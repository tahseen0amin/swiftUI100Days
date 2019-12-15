//
//  UnitConversionView.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 14/12/2019.
//  Copyright © 2019 Taazuh. All rights reserved.
//

import SwiftUI

struct UnitConversionView: View {
    @State private var inputValue = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    
    let units = ["milliliters", "liters", "cups", "pints", "gallons"]
    
    var resultValue : Double {
        var inputValueInMM = 0.0
        let inputVal = Double(inputValue) ?? 0.0
        switch inputUnit {
        case 1:
            inputValueInMM = inputVal * 1000
        case 2:
            inputValueInMM = inputVal * 236.588
        case 3:
            inputValueInMM = inputVal * 473.176
        case 4:
            inputValueInMM = inputVal * 3785.41
        default:
            inputValueInMM = inputVal
        }
        
        var outputValue = 0.0
        switch outputUnit {
            case 1:
                outputValue = inputValueInMM / 1000
            case 2:
                outputValue = inputValueInMM / 236.588
            case 3:
                outputValue = inputValueInMM / 473.176
            case 4:
                outputValue = inputValueInMM / 3785.41
            default:
                outputValue = inputValueInMM
        }
        
        return outputValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert the value FROM")) {
                    Picker("From Value", selection: $inputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("TO")) {
                    Picker("From Value", selection: $outputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    TextField("Enter Input Value", text: $inputValue)
                }
                
                Section(header: Text("Result")) {
                    Text("\(resultValue, specifier: "%.2f") \(self.units[outputUnit])")
                }
            }
            .navigationBarTitle("UNIT CONVERSION")
        }
    }
}

struct UnitConversionView_Previews: PreviewProvider {
    static var previews: some View {
        UnitConversionView()
    }
}
