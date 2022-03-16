//
//  Object.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 07.03.2022.
//

import SwiftUI

struct ObjectView: View, ObjectViewProtocol {
    var object: ObjectProtocol
    
    init(_ object: ObjectProtocol) {
        self.object = object
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            
            switch object.type {
                case .table:
                    tableObject
                default:
                    listObject
            }
        }
        .overlay(
            Rectangle()
                .strokeColor(
                    ColorScheme.shared.getColorForObject(.propertyValue)
                )
        )
        .padding()
    }
    
    var listObject: some View {
        ForEach(object.properties, id: \.id) { property in
            PropertyView(property)
                .padding(.leading, 20)
        }
    }
    
    var tableObject: some View {
        Spacer()
    }
    
    var header: some View {
        HStack {
            switch object.type {
                case .table:
                    Spacer()
                    Text(object.name)
                    Spacer()
                default:
                    Text(object.name)
                    Spacer()
            }
        }
    }
}

struct ObjectView_Previews: PreviewProvider {
    private static let object = Object(
        name: "Object",
        type: .list,
        keywords: [],
        properties: []
    )
    
    static var previews: some View {
        ObjectView(object)
            .frame(width: 300, height: 300)
    }
}
