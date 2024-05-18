//
//  ContentView.swift
//  PyApp
//
//  Created by Bruno Oliveira on 18/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    @State private var showingAnswers = true
    
    var body: some View {
        VStack {
            Text("Map below letters for numbers. Link numbers to letters to turn easy to remember:")
                .padding()
                .font(.headline)
            HStack() {
                ForEach(0..<viewModel.keys.count, id: \.self) { i in
                    VStack {
                        Text(String(i))
                        
                        TextField(String(i), value: $viewModel.keys[i], format: .alphabetIOnly)
                            .foregroundStyle(viewModel.color(forKey: i))
                    }
                    .font(.title2)
                }
            }
            
            Divider()
                .padding(.vertical)
            
            Text("Imagine a seguence of Words that mount phrases easy to remember:")
                .padding()
                .font(.headline)
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach (0..<viewModel.pi.count, id: \.self) { i in
                        HStack {
                            let character = String(viewModel.pi[i])
                            let digit = Int(character) ?? 0
                            
                            Text(character)
                                .monospacedDigit()
                            
                            if character != "." {
                                TextField(viewModel.keys[digit], value: $viewModel.answers[i], format: .alphabetIOnly)
                                    .textFieldStyle(.roundedBorder)
                                    .foregroundStyle(viewModel.color(forAnswer: i))
                                    .opacity(showingAnswers ? 1 : 0)
                            }
                            
                        }
                        .font(.title3)
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Slice of Pi")
        .toolbar {
            Button("Toggle Answers", systemImage: "eye") {
                showingAnswers.toggle()
            }
            .symbolVariant(showingAnswers ? .none : .slash)
            
            Button("Copy", systemImage: "doc.on.doc", action: copyToClipboard)
            
            ShareLink(item: viewModel.outputString, preview: SharePreview("Pi data"))
        }
    }
    
    func copyToClipboard() {
        
        NSPasteboard.general.prepareForNewContents()
        NSPasteboard.general.setString(viewModel.outputString, forType: .string)
        
    }
}

#Preview {
    ContentView()
}
