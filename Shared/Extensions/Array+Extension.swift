//
//  Array+Extension.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 12.03.2022.
//

import Foundation

extension Array: EmptyContent where Element: AnyStruct {
    static var empty: Self { [] }
}
