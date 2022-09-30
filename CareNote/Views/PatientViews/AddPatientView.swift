//
//  AddPatientView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-14.
//

import SwiftUI

struct AddPatientView: View {
    @Environment(\.managedObjectContext) private var viewContext
    /// Calls the environment to dismiss a view or the actual sheet.
    @Environment(\.dismiss) private var dismiss
    
// MARK: - local state properties for the sheet
    @State private var name = ""
    @State private var familyName = ""
    
    @State private var yearMonthDay = ""
    @State private var controlNumbers = ""
    // @State private var swedishSocialSecurityNumber = ""
    
    

    @State private var law: Care.Laws = .HSL
    @State private var date = Date.now
    
    @State private var arriving: Care.HowPatientComeIn = .police
    @State private var details = ""
    
    @State private var anamnes = ""
    @State private var diagnosis = ""
    
    @State private var now = ""
    
    @State private var sRisk: Care.SuicidalRiskNiveau = .low
    
    @State private var vRisk: Care.ViolenceRiskNiveau = .low
    
    @State private var type: Care.TypesOfObservation = .normal
    
    @State private var drug = ""
    
    @State private var medicine = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("ID") {
                    TextField("Name", text: $name)
                    TextField("Family Name", text: $familyName)
                    HStack {
                        TextField("ÅÅÅÅMMDD", text: $yearMonthDay)
                            .keyboardType(.numberPad)
                        Image(systemName: "minus")
                        TextField("NNNN", text: $controlNumbers)
                            .keyboardType(.numberPad)
                    }
                }
                Section("Law, When?") {
                    LawPickerView(
                        law: $law, date: self.$date) // Picker for Type of care and time patient arrived att hospital.
                    HowPatientComeInView(arriving: self.$arriving, details: self.$details) // Picker OR TextEditor.
                }
                Section("Anamnes") {
                    TextEditor(text: $anamnes) // ("PLACEHOLDER FOR What has happened") // TextEditor
                    TextField("Diagnose", text: $diagnosis) // ("PLACEHOLDER FOR Body- and mental-health issues") // TextEditor
                }
                Section("Whats´s important now?") {
                    TextEditor(text: $now) // ("PLACEHOLDER FOR What is important now?") // TextEditor
                    SuicidalRiskPickerView(sRisk: self.$sRisk) // Picker
                    ViolenceRiskPickerView(vRisk: self.$vRisk) // Picker
                    TypeOfObservationView(type: self.$type) // Picker
                }
                Section("Readings") {
                    TextEditor(text: $drug) // Text("PLACEHOLDER FOR Drug-test") // TextEditor OR Multiplychoice-Picker
                }
                Section("Medicine") {
                    TextEditor(text: $medicine) // Text("PLACEHOLDER FOR Medicines") // TextEditor
                }
                
            }
            .navigationTitle("Add Patient")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                        print("The AddPatientView (.sheet) has been dismissed by pressing the 'Cancel'-button.")
                    }
                }
                
                ToolbarItem {
                    Button("Save") {
                        addPatient() // Calls the addPatient function.
                    }
                    .disabled(name.isEmpty || familyName.isEmpty || yearMonthDay.isEmpty || controlNumbers.isEmpty)
                    
                }
            }
        }
    }
// MARK: - Functions for this View
    private func addPatient() {
        withAnimation {
            // let patient <-- insert this instead of "_" in line 103.
            _ = Patient(familyName: familyName, name: name, swedishSocialSecurityNumber: "\(yearMonthDay)-\(controlNumbers)", context: viewContext) // Make an Instance of PatientEntity; vill Instance will be used by the folloing code.
//TODO: - Adding properties to the PatientEntity
            // Add more properties to the Instance of PatientEntity.
                // patient.addToJournal(Journal(date: date, text: law, context: viewContext))
            PersistenceController.shared.save() // Saves the patient.
            print("Patient: \(name) \(familyName) \(yearMonthDay)-\(controlNumbers) adds on the list.")
            dismiss()
            print("The AddPatientView (.sheet) has been dismissed by pressing the 'Save'-button.")
        }
    }
}

struct AddPatientView_Previews: PreviewProvider {
    static var previews: some View {
        AddPatientView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
