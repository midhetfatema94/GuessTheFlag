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
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var currentFlagName = ""
    @State private var rotationAngle: Double = 0
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
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
                            withAnimation() {
                                self.rotationAngle += 360
                            }
                        } else {
                            scoreTitle = "Wrong Answer"
                            score -= 1
                        }
                        currentFlagName = countries[number]
                        self.askQuestion()
                    }, label: {
                        //There are four built-in shapes in Swift: rectangle, rounded rectangle, circle, and capsule
                        Image(self.countries[number])
                            .flagStyle()
                            .accessibility(label: Text(self.labels[self.countries[number]] ?? "Unknown Flag"))
                    })
                    .rotation3DEffect(Angle(degrees: rotationAngle), axis: (x: 0.0, y: 1.0, z: 0.0))
                }
                Text("Your current score is: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
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
