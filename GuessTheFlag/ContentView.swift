//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sofia Muladze on 13/08/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()//randomizza l'ordine dell'array per noi
    @State private var correctAnswer = Int.random(in: 0...2) //random
    
    @State private var showingScore = false//avviso
    @State private var scoreTitle = "" //mostra correct o wrong
    @State private var yourScore = 0//salva il punteggio
    @State private var scoreMessage = ""//messaggio punteggio
    
    var body: some View {

        ZStack {
            //RadialGradient(gradient: Gradient(colors: [.blue, .white ]), center: .center, startRadius: 30, endRadius: 650)
                //.edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                        .foregroundColor(.green)
                    Text(countries[correctAnswer])
                        .font(.system(size: 45))//dimensione font
                        .fontWeight(.black)//spessore font
                        
                }
                
                ForEach(0 ..< 3) { number in //crea un ciclo di 3
                    Button(action: {
                        self.flagTapped(number)//number di ForEach viene passato alla funzione flagTapped
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original) //per lasciare le immagini del colore normale
                            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))//forma immagine
                            //.overlay(Capsule().stroke(Color.black, lineWidth: 1))//linea attorno
                            .shadow(color: .gray, radius: 3)//ombra
                    }
                }
                Text("Your Score Is:  \(yourScore)")
                    .font(.system(size: 30))//dimensione font
                    .fontWeight(.black)//spessore font
                    .foregroundColor(.black)
//                Spacer()
            }
        }
        
        .alert(isPresented: $showingScore) {//avviso
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) { //funzione che verifica la risposta
        if number == correctAnswer {
            scoreTitle = "Correct 😊"
            yourScore += 1
            scoreMessage = "Correct Your score is \(yourScore)"
        } else {
            scoreTitle = "Wrong ☹️"
            scoreMessage = "Wrong This is \(countries[number])'s Flag"
        }

        showingScore = true
    }
    func askQuestion() {//se l'avviso viene ignorato resetta il gioco
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
