//
//  SuicidalRiskPickerView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-18.
//

import SwiftUI

struct SuicidalRiskPickerView: View {
    
    @Binding var sRisk: String // '@Binding' sents back its information to the relevant parent's '@State'-property (can be 'private', but doesn't need to).
    
    var body: some View {
        Picker(selection: $sRisk, label: Text("Suicidal riskniveau")) {
            ForEach(AddPatientView.sRisks, id: \.self) { sRisk in
                Text(sRisk)
            }
        }
    }
}

struct SuicidalRiskPickerView_Previews: PreviewProvider {
    static let sRisks = Care().suicidalRiskNiveau
    @State static private var sRisk = sRisks[0]
    
    static var previews: some View {
        SuicidalRiskPickerView(sRisk: self.$sRisk)
    }
}
