//
//  MedicineDosageView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-11-04.
//

import SwiftUI

struct MedicineDosageView: View {
    // MARK: - local State properties
    @Binding var medicineActiveSubstance: String // Name of the medicine's aktive substance.*
    @Binding var medicineDoseAmount: Double // Amount of t ex tablets.*
    @Binding var medicineForm: Care.Medicine.Form// Form of the medicine.*
    @Binding var medicineName: String// Name of the medicine.*
    @Binding var medicineStrengthValue: Double// strength value.*
    @Binding var medicineStrengthValueUnit: Care.Medicine.Unit// value's unit.*
    
    @Binding var modeOfAdministration: Care.Medicine.ModeOfAdministration// How the medicine gives to the patient.
    // MARK: - Body
    var body: some View {
        Section("Name, Form & Dosage") {
            HStack {
                TextField("Name", text: $medicineName)
                Picker(selection: $modeOfAdministration, label: Text("Administration-mode")) {
                    ForEach(Care.Medicine.ModeOfAdministration.allCases) { mode in
                        Text(mode.rawValue)
                    }
                }
                .labelsHidden()
            }
            
            HStack {
                TextField("Active substance", text: $medicineActiveSubstance)
                Picker(selection: $medicineForm, label: Text("Form")) {
                    ForEach(Care.Medicine.Form.allCases) { form in
                        Text(form.name)
                    }
                }
                .labelsHidden()
            }
            
            HStack {
                TextField("Strength", value: $medicineStrengthValue, format: .number)
                    .keyboardType(.decimalPad)
                Picker(selection: $medicineStrengthValueUnit, label: Text("Unit")) {
                    ForEach(Care.Medicine.Unit.allCases) { unit in
                        Text(unit.rawValue)
                    }
                }
                .labelsHidden()
                .padding([.leading, .trailing])

                
                Image(systemName: "multiply")
                
                TextField("Amount", value: $medicineDoseAmount, format: .number)
                    .keyboardType(.decimalPad)
                
                Image(systemName: "equal")
                
                Text("\(medicineStrengthValue * medicineDoseAmount, format: .number) \(medicineStrengthValueUnit.rawValue)")
            }
            
        }
    }
}
// MARK: - Previews
struct MedicineDosageView_Previews: PreviewProvider {
    @State static private var medicineActiveSubstance: String = "" // Name of the medicine's aktive substance.*
    @State static private var medicineDoseAmount: Double = 1.0 // Amount of t ex tablets.*
    @State static private var medicineForm: Care.Medicine.Form = .tablet // Form of the medicine.*
    @State static private var medicineName: String = "" // Name of the medicine.*
    @State static private var medicineStrengthValue: Double = 1.0 // strength value.*
    @State static private var medicineStrengthValueUnit: Care.Medicine.Unit = .milliGram // value's unit.*
    
    @State static private var modeOfAdministration: Care.Medicine.ModeOfAdministration = .oral // How the medicine gives to the patient.*
    
    static var previews: some View {
        MedicineDosageView(medicineActiveSubstance: self.$medicineActiveSubstance, medicineDoseAmount: self.$medicineDoseAmount, medicineForm: self.$medicineForm, medicineName: self.$medicineName, medicineStrengthValue: self.$medicineStrengthValue, medicineStrengthValueUnit: self.$medicineStrengthValueUnit, modeOfAdministration: self.$modeOfAdministration)
    }
}
