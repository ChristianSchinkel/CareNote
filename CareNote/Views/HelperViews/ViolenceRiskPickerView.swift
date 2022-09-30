//
//  ViolenceRiskPickerView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-18.
//

import SwiftUI

struct ViolenceRiskPickerView: View {
    
    @Binding var vRisk: Care.ViolenceRiskNiveau // '@Binding' sents back its information to the relevant parent's '@State'-property (can be 'private', but doesn't need to).
    
    var body: some View {
        Picker(selection: $vRisk, label: Text("Violential Riskniveau")) {
            ForEach(Care.ViolenceRiskNiveau.allCases, id: \.self) { vRisk in Text(vRisk.rawValue)
            }
        }
    }
}

struct ViolenceRiskPickerView_Previews: PreviewProvider {
    @State static private var vRisk = Care.ViolenceRiskNiveau.low
    
    static var previews: some View {
        ViolenceRiskPickerView(vRisk: self.$vRisk)
    }
}
