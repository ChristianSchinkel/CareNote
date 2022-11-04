//
//  PreScriptionAsNeededView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-11-04.
//

import SwiftUI

struct PreScriptionAsNeededView: View {
    // MARK: - local State properties
    @Binding var asNeeded: Bool // Whether the medicine kan admit as needed or not. *
    @Binding var asNeededMaxDoseAmount: Double // As neededMaxdosamount.*
    @Binding var asNeededMaxDosePerDayDate: Date // As needed max dos per day. TODO: Date isn't handled in a appropriate way..
    @Binding var asNeededMaxDoseStrengthValue: Double // As needed max dos strength value*
    @Binding var asNeededMaxDoseStrengthValueUnit: Care.Medicine.Unit // Ass needed unit
    // MARK: - Body
    var body: some View {
        Section("As needed, maximum dose") {
            Toggle(isOn: $asNeeded) {
                Text("Admits as needed")
            }
            
            HStack {
                TextField("Max dose", value: $asNeededMaxDoseStrengthValue, format: .number)
                    .keyboardType(.decimalPad)
                Picker(selection: $asNeededMaxDoseStrengthValueUnit, label: Text("Unit")) {
                    ForEach(Care.Medicine.Unit.allCases) { unit in
                        Text(unit.rawValue)
                    }
                }
                .labelsHidden()
                .padding([.leading, .trailing])
                
                Image(systemName: "multiply")
                
                TextField("Max Amount", value: $asNeededMaxDoseAmount, format: .number)
                    .keyboardType(.decimalPad)
                
                Image(systemName: "equal")
                
                Text("\(asNeededMaxDoseStrengthValue * asNeededMaxDoseStrengthValue, format: .number) \(asNeededMaxDoseStrengthValueUnit.rawValue)")
            }
            
        }
    }
}
// MARK: - Previews
struct PreScriptionAsNeededView_Previews: PreviewProvider {
    @State static private var asNeeded: Bool = false // Whether the medicine kan admit as needed or not
    @State static private var asNeededMaxDoseAmount: Double = 1.0 // As neededMaxdosamount.*
    @State static private var asNeededMaxDosePerDayDate: Date = Date.now // As needed max dos per day.*
    @State static private var asNeededMaxDoseStrengthValue: Double = 1.0 // As needed max dos strength value*
    @State static private var asNeededMaxDoseStrengthValueUnit: Care.Medicine.Unit = .milliGram // Ass needed unit
    
    static var previews: some View {
        PreScriptionAsNeededView(asNeeded: self.$asNeeded, asNeededMaxDoseAmount: self.$asNeededMaxDoseAmount, asNeededMaxDosePerDayDate: self.$asNeededMaxDosePerDayDate, asNeededMaxDoseStrengthValue: self.$asNeededMaxDoseStrengthValue, asNeededMaxDoseStrengthValueUnit: self.$asNeededMaxDoseStrengthValueUnit)
    }
}
