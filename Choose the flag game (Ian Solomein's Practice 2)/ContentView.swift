//
//  ContentView.swift
//  Choose the flag game (Ian Solomein's Practice 2)
//
//  Created by Пользователь on 14/07/2022.
//  Copyright © 2022 Пользователь. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["uk", "usa", "russia", "greece", "germany", "brazil", "argentina", "canada", "sweden"].shuffled()
    @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var score = 0
    @State private var showAlert = false
    @State private var alerTitle = ""
    @State private var alertMessage = ""
    
    
    var body: some View {
        
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .top, endPoint: .bottom)
                VStack(spacing: 50){
                    Text("\(self.countries[correctAnswer].capitalized)")
                        .font(.largeTitle)
                        .bold()
                    VStack(spacing: 30){
                        ForEach(0..<3){ number in
                            Button(action: {
                                self.flagCheck(number)
                                self.showAlert = true
                            }) {
                                Image(self.countries[number])
                                    .renderingMode(.original)
                                    .clipShape(Rectangle())
                                    .border(Color.black)
                            }
                        }
                    } .alert(isPresented: $showAlert){
                        Alert(title: Text("\(alerTitle)"), message: Text("\(alertMessage)"), dismissButton: .default(Text("Continue")){self.nextRound()})
                    }
                    Text("Your score: \(score)")
                        .font(.largeTitle)
                        .bold()
                }
                .navigationBarTitle("Choose the flag of:", displayMode: .inline)
                .font(.largeTitle)
            }
        }
    }

    func flagCheck(_ number: Int) {
        if number == correctAnswer {
            score += 1
            alerTitle = "Correct"
            alertMessage = "Your score now: \(score)"
        } else {
            score -= 1
            alerTitle = "Incorrect"
            alertMessage = "This is the flag of \(self.countries[number].capitalized)"
        }
    }
    
    func nextRound()  {
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
