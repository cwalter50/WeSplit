//
//  ContentView.swift
//  WeSplit
//
//  Created by Christopher Walter on 4/12/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2) // add 2 because range is from 2 - 100, but indexes are 0 - 98
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0.0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var checkTotal: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let tipAmount = Double(tipPercentages[tipPercentage]) / 100 * orderAmount
        let grandTotal = orderAmount + tipAmount
        return grandTotal
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2 ..< 100) {
                                Text("\($0) people")
                        }
                    }
                }
                Section(header: Text("Check Total")
                    .bold()
                ) {
                    Text("$\(checkTotal, specifier: "%.2f")")
                }
                Section(header: Text("Amount per Person")
                    .bold()
                ) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                Section {
                    Text("How much tip do you want to leave?")
                    Picker("Top Percentage", selection: $tipPercentage) {
                        ForEach(0..<self.tipPercentages.count)
                        {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
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
