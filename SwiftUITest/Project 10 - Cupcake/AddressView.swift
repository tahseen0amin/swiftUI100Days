//
//  AddressView.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 14/01/2020.
//  Copyright © 2020 Taazuh. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order : Order
    
    var body: some View {
        Form {
            Section(){
                TextField("Name", text: $order.address.name)
            }
            
            Section(){
                TextField("Street Name", text: $order.address.streetAddress)
                TextField("City", text: $order.address.city)
                TextField("Zip Code", text: $order.address.zipCode)
            }
            
            Section(){
                NavigationLink(destination: CheckoutView(order: self.order)){
                    Text("Proceed to Checkout")
                }
            }.disabled(!order.address.validAddress)
            
        }.listStyle(GroupedListStyle())
            
        .navigationBarTitle("Address Details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: Order())
        }
    }
}
