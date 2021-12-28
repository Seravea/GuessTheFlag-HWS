//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Romain Poyard on 17/11/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US","Argentine","Afrique du Sud", "Algérie", "Canada","Islande", "Portugal", "Roumanie"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var answerSerie = 0
    var messageRight = "You are right !"
    var messageFalse = "You are wrong !"
    @State private var messageSelected = ""
    
    @State private var score = 0
    
    @State var alertSelected = false
    //    @State private var show = false
    
    var body: some View {
        ZStack {
            ZStack {
                alertSelected ? RadialGradient(stops: [
                    .init(color: Color(red: 1, green: 0.58, blue: 0.278), location: 0.3),
                    .init(color: Color(red: 0.024, green: 0.275, blue: 0.388), location: 0.3)
                ], center: .top, startRadius: 0, endRadius: 2000)
                    .ignoresSafeArea() :
                RadialGradient(stops: [
                    .init(color: Color(red: 1, green: 0.58, blue: 0.278), location: 0.3),
                    .init(color: Color(red: 0.024, green: 0.275, blue: 0.388), location: 0.3)
                ], center: .top, startRadius: 80, endRadius: 500)
                    .ignoresSafeArea()
                
            }
            VStack(spacing: 30) {
                VStack {
                    Text(alertSelected ? "  " : "Tap the good Flag for :")
                        .bold()
                    Text(alertSelected ? "  " : countries[correctAnswer] )
                        .font(.largeTitle)
                        .bold()
                }
                .foregroundColor(.black)
                .padding()
                
                Spacer()
                
                ForEach(0..<3) { number in
                    Button {
                        alerMessage(number)
                    } label: {
                        Image(countries[number])
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: alertSelected ? 0 : 300, maxHeight: alertSelected ? 0 : 170)
                            .clipShape(Capsule())
                            .shadow(radius: 10)
                    }
                    
                    .alert(messageSelected, isPresented: $alertSelected) {
                        if answerSerie == 8 {
                            Button("Restart") {
                                score = 0
                                answerSerie = 0}
                        } else {
                            Button("Go Next") {}
                        }
                    } message: {
                        answerSerie == 8 ? Text("You have found 8 flags congrats ! Let start again") :
                        Text("Your score is \(score)")
                    }
                }
            }
        }
        .animation(Animation.default, value: alertSelected)
    }
    func alerMessage(_ number : Int) {
        if number == correctAnswer {
            messageSelected = messageRight
            score += 1
            countries.shuffle()
            answerSerie += 1
            alertSelected.toggle()
            correctAnswer = Int.random(in: 0...2)
        } else {
            messageSelected = messageFalse
            if score > 0 {
                score -= 1
            }
            answerSerie += 1
            alertSelected.toggle()
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
