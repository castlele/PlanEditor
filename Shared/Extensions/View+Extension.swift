//
//  View+Extension.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 07.03.2022.
//

import SwiftUI

extension Color {
    init(_ pcolor: PColor) {
        #if os(macOS)
        self.init(nsColor: pcolor)
        #else
        self.init(uicolor: pcolor)
        #endif
    }
}
