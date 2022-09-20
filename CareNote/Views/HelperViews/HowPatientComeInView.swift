//
//  HowPatientComeInView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-18.
//

import SwiftUI

struct HowPatientComeInView: View {
    
    @Binding var arriving: String // '@Binding' sents back its information to the relevant parent's '@State'-property (can be 'private', but doesn't need to).
    @Binding var details: String // '@Binding' sents back its information to the relevant parent's '@State'-property (can be 'private', but doesn't need to).
    
    var body: some View {
        VStack {
            Picker(selection: $arriving, label: Text("How come patient in?")) {
                ForEach(AddPatientView.arrivings, id: \.self) { arriving in
                    Text(arriving)
                }
            }
            TextField("Detail", text: $details)
        }
    }
}

struct HowPatientComeInView_Previews: PreviewProvider {
    static private let arrivings = Care().howPatientComeIn
    @State static private var arriving = arrivings[0]
    @State static private var details = ""
    
    static var previews: some View {
        HowPatientComeInView(arriving: self.$arriving, details: self.$details)
    }
}
