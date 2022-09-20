//
//  TypeOfObservationView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-18.
//

import SwiftUI

struct TypeOfObservationView: View {
    
    @Binding var type: String // '@Binding' sents back its information to the relevant parent's '@State'-property (can be 'private', but doesn't need to).
    
    var body: some View {
        Picker(selection: $type, label: Text("Type of Observation")) {
            ForEach(AddPatientView.types, id: \.self) { type in
                Text(type)
            }
        }
    }
}

struct TypeOfObservationView_Previews: PreviewProvider {
    static private let types = Care().typesOfObservation
    @State static private var type = types[0]
    
    static var previews: some View {
        TypeOfObservationView(type: self.$type)
    }
}
