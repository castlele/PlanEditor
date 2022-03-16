//
//  PlanEditor_macOS.swift
//  Tests macOS
//
//  Created by Nikita Semenov on 06.03.2022.
//

import SwiftUI
import HighlightedTextEditor


struct PlanEditor: View {
    @State private var isShowingPreview = false
    
    @EnvironmentObject var interpreter: Interpreter
    
    var body: some View {
        HSplitView {
            HighlightedTextEditor(text: interpreter.content, syntaxHighlighting: Syntax())
                .onTextChange { _ in
                    if isShowingPreview {
                        interpreter.interprete()
                    }
                }
                .toolbar {
                    Button(action: {
                        interpreter.interprete()
                        withAnimation {
                            isShowingPreview.toggle()
                        }
                    }) {
                        Image(systemName: isShowingPreview ? "eye.slash" : "eye")
                    }
                    .help("Show preview")
                    .keyboardShortcut(KeyEquivalent("P"))
                }
            if isShowingPreview {
                PreviewBarView()
            }
        }
    }
}

struct PlanEditor_macOS_Previews: PreviewProvider {
    static var previews: some View {
        PlanEditor()
            .environmentObject(Interpreter(.constant(PlanEditorDocument())))
    }
}
