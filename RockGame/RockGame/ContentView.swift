//
//  ContentView.swift
//  RockGame
//
//  Created by loki on 2020/3/1.
//  Copyright © 2020 loki. All rights reserved.
//

import SwiftUI

struct normalSizeImage: View {
    let url: String
    var body: some View {
        Image(url)
        .renderingMode(.original)
        .resizable()
        .scaledToFit()
        .frame(width: 60, height: 100)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.white, lineWidth: 1))
        .shadow(color: .white, radius: 2)
    }
}
struct QuestionImage: View {
    let url: String
    var body: some View {
        Image(url)
        .renderingMode(.original)
        .resizable()
        .scaledToFit()
        .frame(width: 150, height: 200)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.white, lineWidth: 1))
        .shadow(color: .white, radius: 2)
    }
}
struct ContentView: View {
    @State private var score = 0
    @State private var currentTime = 0
    private let chooese = ["rock", "paper", "scissors"]
    private let winChoose = ["paper", "scissors", "rock"]
    @State private var currentAnswer = Int.random(in: 0...2)
    func _flap (_ number:Int){

        if (currentTime < 10 && winChoose[currentAnswer] == chooese[number]) {
            score+=10
        }
        currentTime+=1
        currentAnswer = Int.random(in: 0...2)
        
    }
    var body: some View {
        VStack {
            Text("请选择能赢的选项")
                .font(.title)
                .fontWeight(.bold)
            
            QuestionImage(url: chooese[currentAnswer])
            HStack{
                ForEach(0..<chooese.count) {number in
                    Button(action:{
                        self._flap(number)
                    }){
                        normalSizeImage(url: self.chooese[number])
                    }
                }
                
            }
            if (currentTime < 10) {
                Text("当前得分: \(score)")
            } else {
                 Text("最终得分: \(score)")
            }
            
           
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
