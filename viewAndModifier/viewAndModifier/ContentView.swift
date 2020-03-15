//
//  ContentView.swift
//  viewAndModifier
//
//  Created by loki on 2020/3/1.
//  Copyright © 2020 loki. All rights reserved.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.red)
    }
}

extension View {
    func blueTitle() -> some View {
        self.modifier(Title())
    }
}
struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            .blueTitle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
