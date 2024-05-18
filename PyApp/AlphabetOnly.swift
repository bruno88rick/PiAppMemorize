//
//  AlphabetOnly.swift
//  PyApp
//
//  Created by Bruno Oliveira on 18/05/24.
//

import Foundation

struct AlphabetOnlyStrategy: ParseStrategy/*, ParseableFormatStyle*/ {
    var allowed = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',.?!`˜ˆ:;"
    
    
    func parse(_ value: String) -> String {
        /*var result = ""
        
        for letter in value  {
            if allowed.contains(letter) {
                result.append(letter)
            }
        }
        return result*/
        value.filter(allowed.contains)
    }
}

struct AlphabetOnlyFormatStrategy: ParseableFormatStyle {
    var parseStrategy = AlphabetOnlyStrategy()
    
    func format(_ value: String) -> String {
        parseStrategy.parse(value)
    }
}


extension FormatStyle where Self == AlphabetOnlyFormatStrategy {
    static var alphabetIOnly: AlphabetOnlyFormatStrategy {
        AlphabetOnlyFormatStrategy()
    }
}
