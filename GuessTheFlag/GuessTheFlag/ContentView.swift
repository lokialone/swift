//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by loki on 2020/1/16.
//  Copyright © 2020 loki. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    let url: String
    var body: some View {
        Image(url)
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.white, lineWidth: 1))
        .shadow(color: .white, radius: 2)
    }
}
struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 30){
                VStack {
                    Text("Tap the flag of")
                        .frame(width: 200)
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3){ number in
                    Button(action: {
                        self.flapped(number)
                    }) {
                        FlagImage(url: self.countries[number])
                            
                    }
                    
                }
                Spacer()
               
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text("Your score is ???"),
                  dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
            })
        }
    }
    
    func flapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "right"
        } else {
            scoreTitle = "wrong"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
