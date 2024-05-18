//
//  ViewModel.swift
//  PyApp
//
//  Created by Bruno Oliveira on 18/05/24.
//

import SwiftUI

@Observable
class ViewModel {
    let pi = Array(Bundle.main.decode("pi5000.txt", as: String.self))
    
    var keys: [String] { didSet{save() } }
    var answers: [String] { didSet{save() } }
    
    let alphabet = "abcdefghijklmnopqrstuvwxyz"
    
    let goodColor = Color.primary
    let badColor = Color.red
    
    let keysURL = URL.documentsDirectory.appending(path: "keys.json")
    let answersURL = URL.documentsDirectory.appending(path: "answers.json")
    
    var outputString: String {
        answers.filter { $0.isEmpty == false }.joined(separator: " ")
    }
    
    init() {
        do {
            let keysData = try Data(contentsOf: keysURL)
            let answersData = try Data(contentsOf: answersURL)
            
            keys = try JSONDecoder().decode([String].self, from: keysData)
            answers = try JSONDecoder().decode([String].self, from: answersData)
        } catch {
            print("There's no data Stored on \(keysURL) or \(answersURL). Assuming standard data to run.")
            keys = Array(repeating: "", count: 10)
            answers = Array(repeating: "", count: pi.count)
        }
    }
    
    func save (){
        do {
            let encodeKeys = try JSONEncoder().encode(keys)
            let encodeAnswers = try JSONEncoder().encode(answers)
            
            try encodeKeys.write(to: keysURL)
            try encodeAnswers.write(to: answersURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func color(forKey index: Int) -> Color {
        let currentValue = keys[index].lowercased()
        
        for letter in currentValue {
            guard alphabet.contains(letter) else {
                return badColor
            }
            
            let matches = keys.filter {
                $0.lowercased().contains(letter)
            }
            
            if matches.count > 1 {
                return badColor
            }
        }
        return goodColor
    }
    
    func color(forAnswer index: Int) -> Color {
        let character = String(pi[index])
        let digit = Int(character) ?? 0
        
        let validStartLetters = keys[digit].lowercased()
        let currentAnswer = answers[index].lowercased()
        
        for letter in validStartLetters {
            if currentAnswer.starts(with: String(letter)) {
                return goodColor
            }
        }
        
        return badColor
    }
}
