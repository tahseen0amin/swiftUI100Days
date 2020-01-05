//
//  AddNewExpenseView.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 05/01/2020.
//  Copyright © 2020 Taazuh. All rights reserved.
//

import SwiftUI

struct AddNewExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var amountString = ""
    @State private var type : ExpenseType = .personal
    
    let expenseTypes : [ExpenseType] = [.personal, .business]
    @ObservedObject var expenses : Expenses
    
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Type in the Title", text: $title).padding()
                TextField("Expense Amount", text: $amountString)
                    .padding()
                    .keyboardType(.numberPad)
                Picker("Select the correct type", selection: $type) {
                    ForEach(self.expenseTypes, id:\.self){
                        Text($0.rawValue)
                    }
                }.padding()
            }.listStyle(GroupedListStyle())
            
            .navigationBarTitle("Add New Expense")
            .navigationBarItems(trailing:
                Button("Save"){
                    guard let amount = Double(self.amountString) else {
                        self.showAlert = true
                        return
                    }
                    let newExpense = ExpenseItem(title: self.title, type: self.type, amount: amount)
                    self.expenses.items.append(newExpense)
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.headline)
            )
        }
        .alert(isPresented: $showAlert) { () -> Alert in
            Alert(title: Text("Error"), message: Text("Seems like amount is entered correctly"), dismissButton: .default(Text("OK")))
        }
    }
}

struct AddNewExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewExpenseView(expenses: Expenses())
    }
}
