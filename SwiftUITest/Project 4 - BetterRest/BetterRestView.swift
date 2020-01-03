//
//  BetterRestView.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 29/12/2019.
//  Copyright © 2019 Taazuh. All rights reserved.
//

import SwiftUI

struct BetterRestView: View {
    @State private var wakeUpTime: Date = defaultWakeUpTime
    @State private var sleepAmount: Double = 8
    @State private var coffeeAmount: Int = 1
    
    private var sleepTime: String {
        calculateBedTime()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("When do you want to wake up ?").font(.headline)
                        DatePicker("Select the Date",selection: $wakeUpTime, displayedComponents:.hourAndMinute)
                            .labelsHidden().datePickerStyle(WheelDatePickerStyle())
                    }.padding()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Desired amount of sleep").font(.headline)
                        Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours");
                        }
                    }.padding()
                    
                    Section(header: Text("Daily Coffee Intake").font(.headline)) {
//                        Picker("Daily Coffee Intake", selection: $coffeeAmount) {
//                            ForEach(1 ..< 20) {
//                                Text("\($0) \($0 == 1 ? "cup" : "cups")")
//                            }
//                        }.labelsHidden()
                        Stepper(value: $coffeeAmount, in: 1 ... 20) {
                            if coffeeAmount == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(coffeeAmount) cups")
                            }
                        }
                    }.padding()
                    
                    Section(header: Text("YOUR IDEAL BEDTIME IS").font(.headline)) {
                        Text(sleepTime)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                    }.padding()
                }
            }
            .navigationBarTitle("Better Rest App")
        }
    }
    
    func calculateBedTime() -> String {
        let model = BetterRest()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
        let hours = (components.hour ?? 0) * 60 * 60
        let minutes = (components.minute ?? 0) * 60
        let wakeUp = Double(hours + minutes)
        
        do {
            let prediction = try model.prediction(wake: wakeUp, estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUpTime - prediction.actualSleep
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: sleepTime)
        } catch {
            return "00:00"
        }
    }
    
    static var defaultWakeUpTime : Date {
        var component = DateComponents()
        component.hour = 7
        component.minute = 30
        return Calendar.current.date(from: component) ?? Date()
    }
}

struct BetterRestView_Previews: PreviewProvider {
    static var previews: some View {
        BetterRestView()
    }
}
