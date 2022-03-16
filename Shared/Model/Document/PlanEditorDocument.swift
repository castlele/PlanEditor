//
//  PlanEditorDocument.swift
//  Shared
//
//  Created by Nikita Semenov on 05.03.2022.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static let planText = UTType(
        exportedAs: "com.castle.PlanEditor.plan"
    )
}

struct PlanEditorDocument: FileDocument {
    var content: String

    init(content: String = "") {
        self.content = content
    }

    static var readableContentTypes: [UTType] { [.planText] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        content = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = content.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
