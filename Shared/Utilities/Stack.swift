//
//  Stack.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 12.03.2022.
//

import Foundation

struct Stack<Content> {
    private let searchingChar: String?
    private let maxAmount: Int
    private var currentAmount = 0
    
    var storage: [Content] = []
    
    var isFound: Bool { maxAmount == currentAmount }
    var isEmpty: Bool { storage.isEmpty }
    
    init(lookingForChar char: String? = nil, amount: Int = 0) {
        self.searchingChar = char
        self.maxAmount = amount
    }
    
    mutating func getOrigin() -> [Content] {
        defer {
            currentAmount = 0
            storage.removeAll()
        }
        return storage
    }
    
    mutating func pop() -> Content? {
        return storage.popLast()
    }
    
    mutating func push(_ el: Content) {
        if let stringElement = el as? String {
            searchChar(in: stringElement)
        }
        storage.append(el)
    }
    
    private mutating func searchChar(in el: String) {
        guard let searchingChar = searchingChar else { return }

        if el.starts(with: searchingChar) {
            currentAmount += 1
        }
    }
}
