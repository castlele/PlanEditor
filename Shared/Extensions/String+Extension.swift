//
//  String+Extension.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 12.03.2022.
//

import Foundation

extension String: AnyStruct {}

extension String {
    var isObject: Bool { self.starts(with: "@") }
    var isComment: Bool { self.starts(with: "\\") }
    var isProperty: Bool { self.trimmingCharacters(in: ["\t", " "]).starts(with: "-") }
    
    var isKeyword: Keyword? {
        for (keywordName, keyword) in Keyword.keywordsList {
            if self.starts(with: keywordName) {
                return keyword
            }
        }
        return nil
    }
    
    func getObjectName() -> String {
        let name = self[index(after: startIndex)..<endIndex]
        return String(name)
    }
    
    func getPropertyName() -> String {
        guard let (startIndex, endIndex) = getFirstParenthesisIndex() else {
            return ""
        }
        let name = String(self[index(after: startIndex)..<endIndex])
            .capitalized
            .replacingOccurrences(of: "_", with: " ")
        
        return name
    }
    
    func getPropertyValue() -> String? {
        guard let firstIndex = self.firstIndex(of: ":") else {
            return nil
        }
        let value = String(self[index(after: firstIndex)..<endIndex])
        
        if value.contains("\"\"\"") {
            return ""
        }
        return value
    }
    
    func getUpdatingDate() -> KeywordDate? {
        guard let (startIndex, endIndex) = getFirstParenthesisIndex() else {
            return nil
        }
        
        let date = String(self[index(after: startIndex)..<endIndex]).lowercased()
        
        if KeywordDate.allCases.contains(where: { $0.rawValue == date } ) {
            return KeywordDate(rawValue: date)
        }
        return nil
    }
    
    func getTillDate() -> Date? {
        guard let (startIndex, endIndex) = getFirstParenthesisIndex() else {
            return nil
        }
        
        let stringDate = String(self[index(after: startIndex)..<endIndex])
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        if let date = dateFormatter.date(from: stringDate) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day, .month, .year], from: date)
            return calendar.date(from: components)
        }
        return nil
    }
    
    private func getFirstParenthesisIndex() -> (start: Index, end: Index)? {
        if let startIndex = self.firstIndex(of: "("),
           let endIndex = self.firstIndex(of: ")") {
            return (startIndex, endIndex)
        } else {
            return nil
        }
    }
}
