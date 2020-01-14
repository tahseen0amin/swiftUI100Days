//
//  OrderView.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 14/01/2020.
//  Copyright © 2020 Taazuh. All rights reserved.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section(){
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }.padding()
                   
                    Stepper(value: $order.quantity, in: 1...20) {
                        Text("Number of cupcakes: \t \(order.quantity)").padding()
                    }
                }
                
                Section(){
                    Toggle(isOn: $order.hasSpecialRequest.animation()) {
                        Text("Do you have a special request?")
                    }
                    
                    if self.order.hasSpecialRequest {
                        Toggle(isOn: $order.extraCream){
                            Text("Need Extra Cream")
                        }
                        
                        Toggle(isOn: $order.extraSprinkle){
                            Text("Need Extra Sprinkle")
                        }
                    }
                }.padding()
                
                NavigationLink(destination: AddressView(order: self.order)){
                    Text("Continue").headlineFont().padding()
                }
                
            }
        .navigationBarTitle("Cupcake Shop")
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
