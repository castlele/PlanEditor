//
//  PreviewBarView.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 07.03.2022.
//

import SwiftUI

struct PreviewBarView: View {
    @EnvironmentObject var interpreter: Interpreter
    
    var body: some View {
        ScrollView {
            if let error = interpreter.error {
                Text("\(error.localizedDescription)")
            } else {
                ForEach(interpreter.objects) { object in
                    ObjectView(object)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PreviewBarView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewBarView()
            .environmentObject(Interpreter(.constant(PlanEditorDocument())))
    }
}
