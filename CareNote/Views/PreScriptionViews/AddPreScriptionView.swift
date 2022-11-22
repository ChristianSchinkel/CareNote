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
    @State private var medicineAmountValue: Double = 1.0
    @State private var medicineAmountValueUnit: String = "st"
    @State private var medicineForm: Care.Medicine.Form = .tablet // Form of the medicine.*
    @State private var medicineName: String = "" // Name of the medicine.*
    @State private var medicineStrengthValue: Double = 1.0 // strength value.*
    @State private var medicineStrengthValueUnit: Care.Medicine.Unit = .milliGram // value's unit.*
    
    @State private var modeOfAdministration: Care.Medicine.ModeOfAdministration = .oral // How the medicine gives to the patient.*
    @State private var reasonOfPrescribing: Care.Medicine.ReasonOfPrescribing = .other // Why the medicine i used. *
    
    @State private var shouldNotBeReplaced: Bool = false
    @State private var shouldNotBeReplacedReason: String = ""
    
    @State private var skippedDate: Date = Date.now // When the medicine marks as skipped.
// MARK: Duration
    @State private var isRepeating: Bool = false // Reminders-list
    @State private var isPlanned: Bool = false
    @State private var treatmentDurationEndDate: Date = Date.TwoWeeksLater(from: Date.now) // When prescription ends.*
    @State private var treatmentDurationEndReason: Care.Medicine.TreatmentDurationEndReason = .plannedStop // Why treatment stops. *
    @State private var treatmentDurationStartDate: Date = Date.now // When prescription starts.*
    /* These are the properties in the the entity */
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    MedicineDosageView(medicineName: $medicineName, medicineForm: $medicineForm, medicineActiveSubstance: $medicineActiveSubstance, medicineStrengthValue: $medicineStrengthValue, medicineStrengthValueUnit: $medicineStrengthValueUnit, medicineAmountValue: $medicineAmountValue, medicineAmountValueUnit: $medicineAmountValueUnit, modeOfAdministration: $modeOfAdministration)
                    
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
    private func addPreScription() {
        withAnimation {
            let newPreScription = PreScription(
                asNeeded: asNeeded,
                asNeededMaxDoseAmount: asNeededMaxDoseAmount,
                asNeededMaxDosePerDayDate: asNeededMaxDosePerDayDate,
                asNeededMaxDoseStrengthValue: asNeededMaxDoseStrengthValue,
                asNeededMaxDoseStrengthValueUnit: asNeededMaxDoseStrengthValueUnit.rawValue,
                frequency: frequency,
                givenDate: givenDate,
                instruction: instruction,
                isGiven: isGiven,
                isPlanned: isPlanned,
                isPrescripted: isPrescripted,
                isSkipped: isSkipped,
                medicineActiveSubstance: medicineActiveSubstance,
                medicineDoseAmount: medicineDoseAmount,
                medicineAmountValue: medicineAmountValue,
                medicineAmountValueUnit: medicineAmountValueUnit,
                medicineForm: medicineForm.rawValue,
                medicineName: medicineName,
                medicineStrengthValue: medicineStrengthValue,
                medicineStrengthValueUnit: medicineStrengthValueUnit.rawValue,
                modeOfAdministration: modeOfAdministration.rawValue,
                reasonOfPrescribing: reasonOfPrescribing.rawValue,
                shouldNotBeReplaced: shouldNotBeReplaced,
                shouldNotBeReplacedReason: shouldNotBeReplacedReason,
                skippedDate: skippedDate,
                treatmentDurationEndDate: treatmentDurationEndDate,
                treatmentDurationEndReason: treatmentDurationEndReason.rawValue,
                treatmentDurationStartDate: treatmentDurationStartDate,
                
                context: viewContext)
            
            
            var computedDate = treatmentDurationStartDate
            var count = 0
            while computedDate <= treatmentDurationEndDate {
                print("The medicine add \(count) time(s).")
                patient.addToMedicine(Medicine.makeObject(name: medicineName, activeSubstance: medicineActiveSubstance, form: medicineForm.rawValue, strengthValue: medicineStrengthValue, strengthValueUnit: medicineStrengthValueUnit.rawValue, amountValue: medicineAmountValue, amountValueUnit: medicineAmountValueUnit, with: computedDate, context: viewContext))
                computedDate = Date.nextDay(from: computedDate)
                print(computedDate)
                count += 1
                
            }
            
            
            patient.addToPreScription(newPreScription)
            
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
