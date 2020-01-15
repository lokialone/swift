//
//  ContentView.swift
//  unit-conversion
//
//  Created by loki on 2020/1/15.
//  Copyright © 2020 loki. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var beforeConversion = ""
    @State private var beforeUnit = 0
    @State private var afterUnit = 0
    
    let lengthUnits = ["meters", "kilometers", "feet", "yards", "miles"]
    let rate = [1, 0.001, 3.28, 1.09,0.0006214]
    var afterConversion: Double {
        let _rate = rate[beforeUnit]
        let afterRate = rate[afterUnit]
        let value = Double(beforeConversion) ?? 0
        return value / _rate * afterRate
    }
    var body: some View {
        Form {
           Text("Hello, World!")
           Section(header: Text("length conversion")) {
            TextField("conversion length", text: $beforeConversion)
            .keyboardType(.decimalPad)
            Picker("Tip percentag", selection: $beforeUnit) {
                   ForEach(0 ..< lengthUnits.count) {
                       Text("\(self.lengthUnits[$0])")
                   }
               }.pickerStyle(SegmentedPickerStyle())
           Text("\(afterConversion, specifier: "%.2f")")
           Picker("Tip percentag", selection: $afterUnit) {
                  ForEach(0 ..< lengthUnits.count) {
                      Text("\(self.lengthUnits[$0])")
                  }
              }.pickerStyle(SegmentedPickerStyle())
            
        }
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
