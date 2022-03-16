//
//  PropertyView.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 07.03.2022.
//

import SwiftUI

struct PropertyView: View, PropertyViewProtocol {
    var property: PropertyProtocol
    
    init(_ property: PropertyProtocol) {
        self.property = property
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Text(property.name)
            Text(property.value)
        }
    }
}

struct PropertyView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyView(Property(name: "NO_NAME", value: "No value here"))
    }
}
