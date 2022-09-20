//
//  ViolenceRiskPickerView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-18.
//

import SwiftUI

struct ViolenceRiskPickerView: View {
    
    @Binding var vRisk: String // '@Binding' sents back its information to the relevant parent's '@State'-property (can be 'private', but doesn't need to).
    
    var body: some View {
        Picker(selection: $vRisk, label: Text("Violential Riskniveau")) {
            ForEach(AddPatientView.vRisks, id: \.self) { vRisk in Text(vRisk)
            }
        }
    }
}

struct ViolenceRiskPickerView_Previews: PreviewProvider {
    static private let vRisks = Care().violenceRiskNiveau
    @State static private var vRisk = vRisks[0]
    
    static var previews: some View {
        ViolenceRiskPickerView(vRisk: self.$vRisk)
    }
}
