//
//  Property.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 07.03.2022.
//

import Foundation

protocol PropertyProtocol {
    var id: String { get }
    var name: String { get set }
    var value: String { get set }
}

protocol PropertyViewProtocol {
    var property: PropertyProtocol { get set }
    
    init(_ property: PropertyProtocol)
}

struct Property: PropertyProtocol {
    var name: String
    var value: String
    
    var id: String { name + UUID().uuidString }
}

extension Property: EmptyContent {
    static var empty: Property { Property(name: "", value: "") }
}
