//
//  HighlightingTextEditor.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 06.03.2022.
//

import SwiftUI
import HighlightedTextEditor

extension HighlightedTextEditor {
    init(text: Binding<String>, syntaxHighlighting syntax: Syntax) {
        self.init(text: text, highlightRules: syntax.highlightingRules)
    }
}
