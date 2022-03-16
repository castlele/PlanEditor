//
//  Syntax.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 06.03.2022.
//

import HighlightedTextEditor
import SwiftUI
#if os(macOS)
import AppKit
#else
import UIKit
#endif

struct Syntax {
    let highlightingRules: [HighlightRule]
    
    init() {
        highlightingRules = [
            HighlightingType.keyword.highlightingRules,
            HighlightingType.propertyName.highlightingRules,
            HighlightingType.propertyValue.highlightingRules,
            HighlightingType.comment.highlightingRules,
            HighlightingType.evaluatedExpression.highlightingRules,
            HighlightingType.object.highlightingRules,
        ].flatMap { $0 }
    }
}

struct HighlightingType {
    enum `Type` {
        case object
        case keyword
        case propertyName
        case propertyValue
        case comment
        case evaluatedExpression
    }
    
    
    static let object = HighlightingType(type: .object)
    static let keyword = HighlightingType(type: .keyword)
    static let propertyName = HighlightingType(type: .propertyName)
    static let propertyValue = HighlightingType(type: .propertyValue)
    static let comment = HighlightingType(type: .comment)
    static let evaluatedExpression = HighlightingType(type: .evaluatedExpression)
    
    private let type: `Type`
    private let colorScheme = ColorScheme.shared
    var highlightingRules: [HighlightRule] = []
    
    private init(type: `Type`) {
        self.type = type
        createRules()
    }
    
    private mutating func createRules() {
        let color = colorScheme.getColorForObject(type)
        
        switch type {
            case .object:
                self.highlightingRules = [
                    HighlightRule(
                        pattern: try! NSRegularExpression(pattern: "@.*", options: []),
                        formattingRules: [TextFormattingRule(key: .foregroundColor, value: color)]
                    )
                ]
            case .keyword:
                self.highlightingRules = [
                    HighlightRule(
                        pattern: try! NSRegularExpression(pattern: "LIST|TABLE|DEFAULT|NUMBERED|LETTERED|NAMED|UNNAMED|NUMBERED|UPDATING_EVERY\\((DAY|WEEK|MONTH|YEAR)\\)|TILL\\(([0-9]{2}.[0-9]{2}.[0-9]{4})\\)", options: []),
                        formattingRules: [TextFormattingRule(key: .foregroundColor, value: color)]
                    )
                ]
            case .propertyName:
                self.highlightingRules = [
                    HighlightRule(
                        pattern: try! NSRegularExpression(pattern: "\\([A-Z0-9_]*\\)", options: []),
                        formattingRules: [TextFormattingRule(key: .foregroundColor, value: color)]
                    )
                ]
            case .propertyValue:
                self.highlightingRules = [
                    HighlightRule(
                        pattern: try! NSRegularExpression(pattern: ":.*", options: []),
                        formattingRules: [TextFormattingRule(key: .foregroundColor, value: color)]
                    ),
                    HighlightRule(
                        pattern: try! NSRegularExpression(pattern: "^.*$", options: []),
                        formattingRules: [TextFormattingRule(key: .foregroundColor, value: color)]
                    ),
                    HighlightRule(
                        pattern: try! NSRegularExpression(pattern: "^'''$", options: []),
                        formattingRules: [TextFormattingRule(key: .foregroundColor, value: color)]
                    )
                ]
            case .comment:
                self.highlightingRules = [
                    HighlightRule(
                        pattern: try! NSRegularExpression(pattern: "\\\\(.*)\\\\", options: []),
                        formattingRules: [TextFormattingRule(key: .foregroundColor, value: color)]
                    )
                ]
            case .evaluatedExpression:
                self.highlightingRules = [
                    HighlightRule(
                        pattern: try! NSRegularExpression(pattern: "\\[(.*)\\]", options: []),
                        formattingRules: [TextFormattingRule(key: .foregroundColor, value: color)]
                    )
                ]
        }
    }
}
