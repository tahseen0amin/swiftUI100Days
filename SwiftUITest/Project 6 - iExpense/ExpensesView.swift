//
//  ExpensesView.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 05/01/2020.
//  Copyright © 2020 Taazuh. All rights reserved.
//

import SwiftUI

enum ExpenseType: String, Codable {
    case personal = "Personal"
    case business = "Business"
}

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let title: String
    let type: ExpenseType
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] = [] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.items){
                UserDefaults.standard.set(encoded, forKey: "Expenses")
            }
        }
    }
    
    init(){
        if let data = UserDefaults.standard.data(forKey: "Expenses"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: data){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ExpensesView: View {
    @ObservedObject var expenses: Expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading){
                            Text(item.title).font(.headline).padding()
                            Text(item.type.rawValue)
                                .font(.footnote)
                                .padding()
                        }
                        Spacer()
                        Text("£\(item.amount, specifier: "%g")").padding().foregroundColor(Color.blue)
                    }
                }.onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpenses")
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        self.showingAddExpense = true
                    }) {
                        Image(systemName: "plus")
                    }.font(.headline)
                    
                    EditButton().padding()
                }
            )
        }
        .sheet(isPresented: $showingAddExpense) {
            AddNewExpenseView(expenses: self.expenses)
        }
        
    }
    
    private func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        let view = ExpensesView()
        let demo = ExpenseItem(title: "Test Title", type: .personal, amount: 20.23)
        view.expenses.items.append(demo)
        return view
    }
}
