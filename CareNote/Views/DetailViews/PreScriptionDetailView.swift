//
//  MedicineDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct PreScriptionDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var patient: Patient
    @ObservedObject var preScription: PreScription
    
    @State private var medicineActiveSubstance: String = "" // Name of the medicine's aktive substance.*
    @State private var medicineDoseAmount: Double = 1.0 // Amount of t ex tablets.*
    @State private var medicineForm: Care.Medicine.Form = .tablet // Form of the medicine.*
    @State private var medicineName: String = "" // Name of the medicine.*
    @State private var medicineStrengthValue: Double = 1.0 // strength value.*
    @State private var medicineStrengthValueUnit: Care.Medicine.Unit = .milliGram // value's unit.*
    @State private var modeOfAdministration: Care.Medicine.ModeOfAdministration = .oral // How the medicine gives to the patient.*
    
    @State private var isPrescripted: Bool = false // Is the medicine prescripted or not.*
    @State private var treatmentDurationEndDate: Date = Date.TwoWeeksLater(from: Date.now) // When prescription ends.*
    @State private var reasonOfPrescribing: Care.Medicine.ReasonOfPrescribing = .other // Why the medicine i used. *
    @State private var treatmentDurationEndReason: Care.Medicine.TreatmentDurationEndReason = .plannedStop // Why treatment stops. *
    @State private var treatmentDurationStartDate: Date = Date.now // When prescription starts.*
    
    @State private var asNeeded: Bool = false // Whether the medicine kan admit as needed or not*
    @State private var asNeededMaxDoseAmount: Double = 1.0 // As neededMaxdosamount.*
    @State private var asNeededMaxDosePerDayDate: Date = Date.now // As needed max dos per day.*
    @State private var asNeededMaxDoseStrengthValue: Double = 1.0 // As needed max dos strength value*
    @State private var asNeededMaxDoseStrengthValueUnit: Care.Medicine.Unit = .milliGram // Ass needed unit*
    
    @State private var isRepeating: Bool = false // flips the boolean for if there is any redundancy in the prescription and shows options to choose (takes input from 'preScription.isPlanned').
    
    @State private var instruction: String = "" // additional instructions for administration.
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    MedicineDosageView(medicineActiveSubstance: $medicineActiveSubstance, medicineDoseAmount: $medicineDoseAmount, medicineForm: $medicineForm, medicineName: $medicineName, medicineStrengthValue: $medicineStrengthValue, medicineStrengthValueUnit: $medicineStrengthValueUnit, modeOfAdministration: $modeOfAdministration)
                    
                    PreScriptionDurationView(isPrescripted: $isPrescripted, treatmentDurationEndDate: $treatmentDurationEndDate, reasonOfPrescribing: $reasonOfPrescribing, treatmentDurationEndReason: $treatmentDurationEndReason, treatmentDurationStartDate: $treatmentDurationStartDate)
                    
                    PreScriptionAsNeededView(asNeeded: $asNeeded, asNeededMaxDoseAmount: $asNeededMaxDoseAmount, asNeededMaxDosePerDayDate: $asNeededMaxDosePerDayDate, asNeededMaxDoseStrengthValue: $asNeededMaxDoseStrengthValue, asNeededMaxDoseStrengthValueUnit: $asNeededMaxDoseStrengthValueUnit)
                    
                    RemindersView(asNeeded: $asNeeded, isRepeating: $isRepeating)
                    
                    TextField("Instructions", text: $instruction)
                }
                .onAppear {
                    medicineActiveSubstance = preScription.medicineActiveSubstance
                    medicineDoseAmount = preScription.medicineDoseAmount
                    medicineForm =  Care.Medicine.Form(rawValue: preScription.medicineForm) ?? Care.Medicine.Form.tablet
                    medicineName = preScription.medicineName
                    medicineStrengthValue = preScription.medicineStrengthValue
                    medicineStrengthValueUnit = Care.Medicine.Unit(rawValue: preScription.medicineStrengthValueUnit) ?? Care.Medicine.Unit.mikroGram
                    modeOfAdministration = Care.Medicine.ModeOfAdministration(rawValue: preScription.modeOfAdministration) ?? Care.Medicine.ModeOfAdministration.oral
                    
                    isPrescripted = preScription.isPrescripted
                    treatmentDurationEndDate = preScription.treatmentDurationEndDate
                    reasonOfPrescribing = Care.Medicine.ReasonOfPrescribing(rawValue: preScription.reasonOfPrescribing) ?? Care.Medicine.ReasonOfPrescribing.other
                    treatmentDurationEndReason = Care.Medicine.TreatmentDurationEndReason(rawValue:preScription.treatmentDurationEndReason) ?? Care.Medicine.TreatmentDurationEndReason.plannedStop
                    treatmentDurationStartDate = preScription.treatmentDurationStartDate
                    
                    asNeeded = preScription.asNeeded
                    asNeededMaxDoseAmount = preScription.asNeededMaxDoseAmount
                    asNeededMaxDosePerDayDate = preScription.asNeededMaxDosePerDayDate
                    asNeededMaxDoseStrengthValue = preScription.asNeededMaxDoseStrengthValue
                    asNeededMaxDoseStrengthValueUnit = Care.Medicine.Unit(rawValue: preScription.asNeededMaxDoseStrengthValueUnit) ?? Care.Medicine.Unit.milliGram
                    
                    isRepeating = preScription.isPlanned // flips the boolean for if there is any redundancy in the prescription and shows options to choose.
                    
                    instruction = preScription.instruction
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Check for elements of medicine now or later.
                        
                        // Delete all elements nor or in the future.
                        
                        // recreate all elements in the list with new values until end of prescription.
                        
                        print("Edited medicine to \(preScription.medicineForm)")
//                        PersistenceController.shared.save()
                        
                        dismiss()
                    }
                }
            }
            .navigationTitle("Edit Prescription")
        }
    }
// MARK: - Functions for this View:
    
}

struct PreScriptionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PreScriptionDetailView(patient: Patient.example(context: PersistenceController.preview.container.viewContext), preScription: PreScription.example(context: PersistenceController.preview.container.viewContext))
    }
}
