//
//  GuessTheFlag2.swift
//  GuessTheFlag
//
//  Created by Romain Poyard on 28/12/2021.
//

import SwiftUI

struct GuessTheFlag2: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US","Argentine","Afrique du Sud", "Algérie", "Canada","Islande", "Portugal", "Roumanie"].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    @State private var alertSelected = false
    @State private var alertMessage = ""
    @State private var score = 0
    @State private var restartGame = 0
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.082, green: 0.055, blue: 0.337), location: 0.3),
                .init(color: Color(red: 0.482, green: 0.067, blue: 0.227), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.black)
                    
                    Text(countries[correctAnswer])
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)
                    
                    VStack(spacing: 15) {
                        ForEach(0..<3) { number in
                            Button {
                                messageAlert(number)
                            }label: {
                                Image(countries[number])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: 200, maxHeight: 100)
                                    .clipShape(Capsule())
                                    .shadow(radius: 10)
                                    .padding(.bottom, 10)
                            }
                        }
                        .alert(alertMessage, isPresented: $alertSelected) {
                            Button(restartGame == 12 ? "Restart the game" : "Continue", action: askQuestion)
                        } message: {
                            Text("Your score is \(score)")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                
                Spacer()
                
                Text("Score : \(score)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Spacer()
                Spacer()
            }
        }
    }
    
    func messageAlert(_ number: Int) {
        if correctAnswer == number {
            alertMessage = "Correct !"
            
            score += 1
            restartGame += 1
            alertSelected.toggle()
        } else {
            alertMessage = "Wrong !"
            if score > 0 {
                score -= 1
            }
            restartGame += 1
            alertSelected.toggle()
        }
    }
    
    func askQuestion() {
        if restartGame >= 12 {
            countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US","Argentine","Afrique du Sud", "Algérie", "Canada","Islande", "Portugal", "Roumanie"]
            score = 0
            restartGame = 0
            countries.remove(at: correctAnswer)
        } else {
            countries.remove(at: correctAnswer)
            correctAnswer = Int.random(in: 0...2)
        }
    }
}

struct GuessTheFlag2_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlag2()
    }
}
