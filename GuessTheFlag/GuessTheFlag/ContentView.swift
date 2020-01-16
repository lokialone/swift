//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by loki on 2020/1/16.
//  Copyright © 2020 loki. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
        VStack{
            Button("Show Alert"){
                self.showingAlert = true;
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Hello swift ui"), message: Text("This is content "), dismissButton: .default(Text("Ok")))
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
