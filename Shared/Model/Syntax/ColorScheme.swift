//
//  Theme.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 06.03.2022.
//

import Foundation

#if os(macOS)
import AppKit
typealias PColor = NSColor
#else
import UIKit
typealias PColor = UIColor
#endif

final class ColorScheme {
    static let shared = ColorScheme()
    
    enum Scheme {
        case defaultBlack
        case defaultWhite
    }
    
    private var currentScheme: Scheme = .defaultWhite
    
    private init() {}
    
    func changeScheme(_ scheme: Scheme) {
        currentScheme = scheme
    }
    
    func getColorForObject(_ type: HighlightingType.`Type`) -> PColor {
        var colorName = ""
        switch type {
            case .object:
                colorName = "syn.object.color"
            case .propertyName:
                colorName = "syn.property.name.color"
            case .propertyValue:
                colorName = "syn.property.value.color"
            case .comment:
                colorName = "syn.comment.color"
            case .keyword:
                colorName = "syn.keyword.color"
            case .evaluatedExpression:
                colorName = "syn.evaluatedExpression.color"
        }
        return PColor(named: colorName)!
    }
}
