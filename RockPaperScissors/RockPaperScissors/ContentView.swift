//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by ZML-MAC-RahulM-01 on 14/08/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userSelection: String?
    @State private var computerMove =  Move.allCases.randomElement()!
    @State private var goalValue = Goal.allCases.randomElement()!
    @State private var selectedMove = "Select a move 🀄️"
    @State private var userScore: Int = 0
    @State private var totalRounds: Int = 1
    @State private var hasAnswered: Bool = false
    @State private var showGameOver: Bool = false
    @State private var showComputerMove: Bool = false
    @State private var result: Result = .draw
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing:40) {
                Text("Rounds \(totalRounds) / 10 ")
                
                Text("Score : \(userScore)")
            }
            .font(.system(size: 25,weight: .medium))
            .padding(.horizontal)
            
            Spacer()
            Text(selectedMove)
                .font(.system(size: 40,weight: .bold))
            
            Spacer()
            
            Text("\(selectedMove) \(result)'s to \(computerMove.rawValue)")
                .blur(radius: showComputerMove ? 0 : 10)
                
            Spacer()
            //Player choices
            VStack(spacing: 12) {
                
                Button(Move.rock.rawValue) {
                    selectedMove = Move.rock.rawValue
                    checkAnswer(playerMove: .rock)
                    hasAnswered = true
                    showComputerMove = true
                    
                }
                .frame(width: 200,height: 60)
                .background(.red)
                .foregroundStyle(.black)
                
                
                Button(Move.paper.rawValue) {
                    selectedMove = Move.paper.rawValue
                    checkAnswer(playerMove: .paper)
                    hasAnswered = true
                    showComputerMove = true
                }
                .frame(width: 200,height: 60)
                .background(.blue)
                .foregroundStyle(.black)
                
                Button(Move.scissors.rawValue) {
                    selectedMove = Move.scissors.rawValue
                    checkAnswer(playerMove: .scissors)
                    hasAnswered = true
                    showComputerMove = true
                }
                .frame(width: 200,height: 60)
                .background(.green)
                .foregroundStyle(.black)
                
            }
            .padding(.vertical)
            .disabled(hasAnswered)
            
            Text("👉 You must \(String(describing: goalValue))")
                .font(.title2)
            
            Spacer()
            
            VStack {
                Button(role: .confirm) {
                    selectedMove = "Select a move 🀄️"
                } label: {
                    Text("CLEAR")
                }
                .frame(width: 200,height: 60)
                .clipShape(.buttonBorder)
                .foregroundStyle(.black)
                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                .shadow(color: .black, radius: 1)
                
                Button(role: .confirm) {
                    if totalRounds == 10 {
                        showGameOver = true
                    } else {
                        totalRounds += 1
                    }
                    computerMove = Move.allCases.randomElement()!
                    goalValue = Goal.allCases.randomElement()!
                    hasAnswered = false
                    showComputerMove = false
                    selectedMove = "Select a move 🀄️"
                    
                } label: {
                    Text("NEXT")
                }
                .frame(width: 200,height: 60)
                .background(.yellow)
                .clipShape(.buttonBorder)
                .foregroundStyle(.black)
            }
        }
        .padding()
        .alert("Game Over", isPresented: $showGameOver) {
            Button("Play Again") {
                resetGame()
            }
            
            Button("Done",role: .cancel) {
                
            }
        } message : {
            Text("You completed all 10 rounds. \nYour final score is \(userScore)")
        }
    }
    
    func checkAnswer(playerMove: Move) {
        print(playerMove)
        showComputerMove = true
        let result: Result
        
        switch playerMove {
        case .rock:
            switch computerMove {
            case .rock:
                result = .draw
                
            case .paper:
                result = .lose
                
            case .scissors:
                result = .win
            }
            
        case .paper:
            switch computerMove {
            case .rock:
                result = .win
                
            case .paper:
                result = .draw
                
            case .scissors:
                result = .lose
            }
            
            
        case .scissors:
            switch computerMove {
            case .rock:
                result = .lose
                
            case .paper:
                result = .win
                
            case .scissors:
                result = .draw
            }
        }
        
        
        switch result {
        case .win:
            if goalValue == .win {
                userScore += 1
            } else {
                userScore -= 1
            }
            
        case .lose:
            if goalValue == .lose {
                userScore += 1
            } else {
                userScore -= 1
            }
            
        case .draw:
            break
            
        }
        self.result = result
    }
    
    enum Move: String, CaseIterable {
        case rock = "ROCK 🪨"
        case paper = "PAPER 🧻"
        case scissors = "SCISSORS ✂️"
    }
    
    enum Goal: String, CaseIterable {
        case win = "Win"
        case lose = "Lose"
    }
    
    enum Result: String {
        case win = "Win"
        case lose = "Lose"
        case draw = "Draw"
    }
    
    func nextRound() {
        if totalRounds == 10 {
            showComputerMove = true
        } else {
            showComputerMove = false
        }
        computerMove = Move.allCases.randomElement()!
        goalValue = Goal.allCases.randomElement()!
        selectedMove = "Select a move 🀄️"
        hasAnswered = false
        showComputerMove = false
        showGameOver = false
    }
    
    func resetGame() {
        totalRounds = 1
        userScore = 0
        
        nextRound()
    }
}

#Preview {
    ContentView()
}
