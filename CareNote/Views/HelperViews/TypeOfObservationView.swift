//
//  TypeOfObservationView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-18.
//

import SwiftUI

struct TypeOfObservationView: View {
    
    @Binding var type: Care.TypesOfObservation // '@Binding' sents back its information to the relevant parent's '@State'-property (can be 'private', but doesn't need to).
    
    var body: some View {
        Picker(selection: $type, label: Text("Type of Observation")) {
            ForEach(Care.TypesOfObservation.allCases, id: \.self) { type in
                Text(type.rawValue)
            }
        }
    }
}

struct TypeOfObservationView_Previews: PreviewProvider {
    @State static private var type = Care.TypesOfObservation.normal
    
    static var previews: some View {
        TypeOfObservationView(type: self.$type)
    }
}
