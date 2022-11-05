//
//  AddMedicineView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct AddPreScriptionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    /// Calls the environment to dismiss a view or the actual sheet.
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var patient: Patient
    
// MARK: - local state properties for the sheet
    
    @State private var asNeeded: Bool = false // Whether the medicine kan admit as needed or not*
    @State private var asNeededMaxDoseAmount: Double = 1.0 // As neededMaxdosamount.*
    @State private var asNeededMaxDosePerDayDate: Date = Date.now // As needed max dos per day.*
    @State private var asNeededMaxDoseStrengthValue: Double = 1.0 // As needed max dos strength value*
    @State private var asNeededMaxDoseStrengthValueUnit: Care.Medicine.Unit = .milliGram // Ass needed unit*
    
    @State private var datesForAdministration: Date?
    @State private var frequency: String = "" // How often the medicine gives in a period of time.
    
    @State private var givenDate: Date = Date.now // When the medicine gives to patient.
    
    @State private var instruction: String = "" // additional instructions for administration.
    
    @State private var isGiven: Bool = false // Is the medicine given or not.
    @State private var isPrescripted: Bool = false // Is the medicine prescripted or not.*
    @State private var isSkipped: Bool = false // Is the medicine skipped or not.
// MARK: Medicine dosage
    @State private var medicineActiveSubstance: String = "" // Name of the medicine's aktive substance.*
    @State private var medicineDoseAmount: Double = 1.0 // Amount of t ex tablets.*
    @State private var medicineForm: Care.Medicine.Form = .tablet // Form of the medicine.*
    @State private var medicineName: String = "" // Name of the medicine.*
    @State private var medicineStrengthValue: Double = 1.0 // strength value.*
    @State private var medicineStrengthValueUnit: Care.Medicine.Unit = .milliGram // value's unit.*
    
    @State private var modeOfAdministration: Care.Medicine.ModeOfAdministration = .oral // How the medicine gives to the patient.*
    @State private var reasonOfPrescribing: Care.Medicine.ReasonOfPrescribing = .other // Why the medicine i used. *
    
    @State private var shouldNotBeReplaced: Bool = false
    @State private var shouldNotBeReplacedReason: String?
    
    @State private var skippedDate: Date = Date.now // When the medicine marks as skipped.
// MARK: Duration
    @State private var isRepeating: Bool = false // Reminders-list
    @State private var treatmentDurationEndDate: Date = Date.TwoWeeksLater(from: Date.now) // When prescription ends.*
    @State private var treatmentDurationEndReason: Care.Medicine.TreatmentDurationEndReason = .plannedStop // Why treatment stops. *
    @State private var treatmentDurationStartDate: Date = Date.now // When prescription starts.*
    /* These are the properties in the the entity */
    
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
            }
            .navigationTitle("Add Prescription")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                        print("The AddPreScriptionView (.sheet) has been dismissed by pressing the 'Cancel'-button.")
                    }
                }
                
                ToolbarItem {
                    Button("Save") {
                        // Action
                        addPreScription() // Calls the addMedicine()
                    }
                    .disabled(medicineName.isEmpty)
                }
            }
        }
    }
// MARK: - Functions for this View:
    /// Toggles the bolean of the toggles "isSkipped" and "isGiven"
    private func changeToggle() {
        if isSkipped == false {
            if isGiven == true {
                isGiven.toggle()
            }
        } else if isGiven == false {
            isSkipped.toggle()
        }
    }
    
    private func addPreScription() {
        withAnimation {
//            patient.addToMedicine(
//                Medicine(
//                    datePrescriptionIsStarting: datePrescriptionIsStarting,
//                    dateGiven: dateGiven,
//                    datePrescriptionIsEnding: datePrescriptionIsEnding,
//                    dateSkipped: dateSkipped,
//                    name: name,
//                    form: form.name,
//                    frequency: frequency,
//                    strength: strength,
//                    unit: unit.rawValue,
//                    amount: amount,
//                    instruction: instruction,
//                    isGiven: isGiven,
//                    isPrescripted: isPrescripted,
//                    isSkipped: isSkipped,
//                    context: viewContext)) //_ = Medicine(date: date, name: name, context: viewContext)
            
            PersistenceController.shared.save() // Saves the patient.
           // print("Patient: \(name) \(familyName) \(swedishSocialSecurityNumber) adds on the list.")
           dismiss()
           // print("The AddLawView (.sheet) has been dismissed by pressing the 'Save'-button.")
        }
    }
}

struct AddPreScriptionView_Previews: PreviewProvider {
    static var previews: some View {
        AddPreScriptionView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
