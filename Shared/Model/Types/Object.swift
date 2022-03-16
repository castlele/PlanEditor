//
//  Object.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 07.03.2022.
//

import Foundation

protocol ObjectProtocol {
    var name: String { get set }
    var type: Keyword { get set }
    var keywords: [Keyword] { get set }
    var properties: [PropertyProtocol] { get set }
    
    func applyKeywords()
}

protocol ObjectViewProtocol {
    var object: ObjectProtocol { get set }
    
    init(_ object: ObjectProtocol)
}

struct Object: ObjectProtocol {
    var name: String
    var type: Keyword
    var keywords: [Keyword]
    var properties: [PropertyProtocol]
    
    func applyKeywords() {
        
    }
}

extension Object: Identifiable {
    var id: String { name }
}

extension Object: AnyStruct {}

extension Object: EmptyContent {
    static var empty: Object { Object(name: "", type: .list, keywords: [], properties: []) }
}
