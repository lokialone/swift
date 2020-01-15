//
//  ContentView.swift
//  check-split
//
//  Created by loki on 2020/1/12.
//  Copyright © 2020 loki. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    var grandTotal: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let tipMount = Double(tipPercentages[tipPercentage])
        let tipValue = orderAmount / 100 * tipMount
        let grandTotal = orderAmount + tipValue
        return grandTotal
    }
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0 + 2.0
         let amountPerPerson = grandTotal / peopleCount
         return amountPerPerson
     }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of people", text: $numberOfPeople)
                    .keyboardType(.decimalPad)
//                    Picker("Number of people", selection: $numberOfPeople) {
//                       ForEach(2 ..< 10) {
//                           Text("\($0) people")
//                       }
//                   }
                }
                Section(header: Text("How much tips do you want to leave?")) {
                    Picker("Tip percentag", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("total amount")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                }
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
            }.navigationBarTitle("WeSplit")
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
