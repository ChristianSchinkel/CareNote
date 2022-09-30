//
//  SuicidalRiskPickerView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-18.
//

import SwiftUI

struct SuicidalRiskPickerView: View {
    
    @Binding var sRisk: Care.SuicidalRiskNiveau // '@Binding' sents back its information to the relevant parent's '@State'-property (can be 'private', but doesn't need to).
    
    var body: some View {
        Picker(selection: $sRisk, label: Text("Suicidal riskniveau")) {
            ForEach(Care.SuicidalRiskNiveau.allCases, id: \.self) { sRisk in
                Text(sRisk.rawValue)
            }
        }
    }
}

struct SuicidalRiskPickerView_Previews: PreviewProvider {
    static let sRisks = Care().suicidalRiskNiveau
    @State static private var sRisk = Care.SuicidalRiskNiveau.low
    
    static var previews: some View {
        SuicidalRiskPickerView(sRisk: self.$sRisk)
    }
}
