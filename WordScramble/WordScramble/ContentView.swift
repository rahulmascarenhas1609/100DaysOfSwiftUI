//
//  ContentView.swift
//  WordScramble
//
//  Created by ZML-MAC-RahulM-01 on 25/08/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var userScore = 0
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter a word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
                
                Section {
                    Text("The user score is: \(userScore.description)")
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("Restart") {
                    withAnimation {
                        newWord = ""
                        usedWords = []
                        userScore = 0
                        startGame()
                    }
                }
            }
        }
        .onSubmit(addNewWord)
        .onAppear(perform: startGame)
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
        
    }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we dont add duplicate words
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if the remaining string is empty
        guard answer.count > 0 else { return }
        
        guard answer.count > 3 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognised", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            userScore += answer.count
        }
        newWord = ""
    }
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordURL, encoding: .utf8) {
                // 3.SPlit the string up into an array of strings, splitting on line breaks.
                let allWords = startWords.components(separatedBy: "\n")
                
                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                // If we are here everything has worked, so we can exit
                return
            }
        }
        
        //If we are *here* then there was a problem - trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    /// if we create a variable copy of the root word, we can then loop over each letter of the user’s input word to see if that letter exists in our copy.
    /// If it does, we remove it from the copy (so it can’t be used twice), then continue.
    /// If we make it to the end of the user’s word successfully then the word is good, otherwise there’s a mistake and we return false.
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in tempWord {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    /// make an instance of UITextChecker, which is responsible for scanning strings for misspelled words.
    /// We’ll then create an NSRange to scan the entire length of our string, then call rangeOfMisspelledWord() on our text checker so that it looks for wrong words.
    /// When that finishes we’ll get back another NSRange telling us where the misspelled word was found, but if the word was OK the location for that range will be the special value NSNotFound.
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String,message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}


#Preview {
    ContentView()
}
