//
//  View+extension.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 07.03.2022.
//

import SwiftUI

extension Shape {
    func strokeColor(_ color: PColor, lineWidth: CGFloat = 1) -> some View {
        self.stroke(Color(color), lineWidth: lineWidth)
    }
}
