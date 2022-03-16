//
//  ContentView.swift
//  Shared
//
//  Created by Nikita Semenov on 05.03.2022.
//

import SwiftUI
import HighlightedTextEditor

struct EditorView: View {
    @EnvironmentObject var interpreter: Interpreter
    
    var body: some View {
        PlanEditor()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView()
            .environmentObject(Interpreter(.constant(PlanEditorDocument())))
    }
}
