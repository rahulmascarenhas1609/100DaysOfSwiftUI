//
//  ContentView.swift
//  MathBuilder
//
//  Created by ZML-MAC-RahulM-01 on 21/09/26.
//

import SwiftUI

struct Question {
    let input: String
    let answer: Int
}

enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    // Defines the multiplier range for each difficulty
    var multiplierRange: ClosedRange<Int> {
        switch self {
            case .easy:
            return 1...5
        case .medium:
            return 1...12
        case .hard:
            return 6...20
        }
    }
}

struct ContentView: View {
    
    // Settings State
    @State private var selectedTable = 2
    @State private var questionCount = 5
    @State private var selectedDifficulty: Difficulty = .medium
    private let questionOptions = [5,10,20]
    
    // Game State
    @State private var gameStarted = false
    @State private var questions: [Question] = []
    @State private var currentQuestion = 0
    @State private var userAnswer = ""
    @State private var score = 0
    @State private var showScoreAlert = false
    
    var body: some View {
        NavigationStack {
            if gameStarted {
                gamePlayView
            } else {
                settingsView
            }
        }
    }
    
    private var settingsView: some View {
        Form {
            Section("Select Times Table") {
                Stepper("table of \(selectedTable)", value: $selectedTable, in: 2...12)
            }
            
            Section("Select Difficulty") {
                Picker("Difficulty", selection: $selectedDifficulty) {
                    ForEach(Difficulty.allCases, id: \.self) { level in
                        Text(level.rawValue)
                    }
                }
            }
            Section("Number of Questions") {
                Picker("Questions", selection: $questionCount) {
                    ForEach(questionOptions,id: \.self) { count in
                            Text("\(count)")
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Button("Start Practice", action: startGame)
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
        }
        .navigationTitle(Text("Math Builder"))
    }
    
    // 2.Active Quiz Screen
    private var gamePlayView: some View {
        VStack(spacing: 24) {
            Text("Question \(currentQuestion + 1) of \(questionCount)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Text(questions[currentQuestion].input)
                .font(.largeTitle.bold())
            
            TextField("Your Answer", text: $userAnswer)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding(.horizontal, 40)
            
            Button("Submit Answer", action: checkAnswer)
                .buttonStyle(.borderedProminent)
                .disabled(userAnswer.isEmpty)
            
            Spacer()
        }
        .padding(.top, 40)
        .navigationTitle("Score : \(score)")
        .toolbar {
            Button("Quit") { gameStarted = false }
        }
        .alert("Practice Complete!", isPresented: $showScoreAlert) {
            Button("Play Again") { gameStarted = false }
        } message: {
            Text("You scored \(score) out of \(questionCount)")
        }
    }
    
    // 3.Game Logic
    private func startGame() {
        questions = (0..<questionCount).map { _ in
            let multiplier = Int.random(in: selectedDifficulty.multiplierRange)
            return Question(
                input: "\(selectedTable) x \(multiplier) = ?", answer: selectedTable * multiplier)
        }
        currentQuestion = 0
        score = 0
        userAnswer = ""
        gameStarted = true
    }
    
    private func checkAnswer() {
        if Int(userAnswer) == questions[currentQuestion].answer {
            score += 1
        }
        
        userAnswer = ""
        
        if currentQuestion + 1 < questions.count {
            currentQuestion += 1
        } else {
            showScoreAlert = true
        }
    }
}

#Preview {
    ContentView()
}
