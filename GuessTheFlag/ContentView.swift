//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Midhet Sulemani on 11/8/20.
//  Copyright © 2020 Sulemani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var currentFlagName = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 30) {
                VStack() {
                    Text("Tap the flag of: ")
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text(countries[correctAnswer])
                        .font(.title)
                        .fontWeight(.bold)
                }
                ForEach(0 ..< 3) {number in
                    Button(action: {
                        //flag is tapped
                        if number == correctAnswer {
                            scoreTitle = "Correct Answer!"
                            score += 1
                        } else {
                            scoreTitle = "Wrong Answer"
                            score -= 1
                        }
                        currentFlagName = countries[number]
                        showingScore = true
                    }, label: {
                        //There are four built-in shapes in Swift: rectangle, rounded rectangle, circle, and capsule
                        Image(self.countries[number])
                            .flagStyle()
                    })
                }
                Text("Your current score is: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("That is the flag of \(currentFlagName)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

extension Image {
    func flagStyle() -> some View {
        self
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1.0))
            .shadow(color: .black, radius: 10)
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
