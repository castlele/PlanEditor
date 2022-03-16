//
//  PlanEditorApp.swift
//  Shared
//
//  Created by Nikita Semenov on 05.03.2022.
//

import SwiftUI

@main
struct PlanEditorApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: PlanEditorDocument()) { file in
            EditorView()
                .environmentObject(Interpreter(file.$document))
        }
    }
}
