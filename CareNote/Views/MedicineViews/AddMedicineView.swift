//
//  AddMedicineView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct AddMedicineView: View {
    @Environment(\.managedObjectContext) private var viewContext
    /// Calls the environment to dismiss a view or the actual sheet.
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var patient: Patient
    
// MARK: - local state properties for the sheet
    
    
    @State private var date = Date.now // Date of Prescription.
    @State private var datePrescriptionIsEnding = Date.distantFuture // Date Prescription is ending.
    @State private var dateGiven = Date.now // Date the medicine is given.
    @State private var dateSkipped = Date.now // Date the medicine is skipped.
    @State private var name = "" // Name of medicine or substans.
    @State private var form: Care.Medicine.Form = .tablet
    @State private var frequency = ""
    @State private var strength = 1.0
    @State private var unit: Care.Medicine.Unit = .milliGram
    @State private var amount = 1.0
    @State private var instruction = "" // additional instructions for administration.
    @State private var isPrescripted = false
    @State private var isGiven = false
    @State private var isSkipped = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    VStack {
                        Toggle(isOn: $isPrescripted) { // whether it is prescribed or not.
                            Text("Prescripted On:")
                        }
                        
                        HStack {
                            DatePicker("Please enter a date", selection: $date) // Prescription-date.
                                .labelsHidden()
                            Spacer()
                        }
                        
                        HStack {
                            DatePicker("Ending on:", selection: $datePrescriptionIsEnding) // Prescription ending on date.
                            Spacer()
                        }
                    }
                    
                    TextField("Medication name", text: $name)
                    Picker(selection: $form, label: Text("Medication form")) {
                        ForEach(Care.Medicine.Form.allCases, id: \.self) { form in
                            Text(form.name)
                        }
                    }
                    
                    TextField("Medication frequency", text: $frequency)
                    
                    HStack {
                        TextField("Strength", value: $strength, format: .number)
                            .keyboardType(.decimalPad)
                        
                        //TextField("Unit", text: $unit)
                        Picker(selection: $unit, label: Text("Unit")) {
                            ForEach(Care.Medicine.Unit.allCases, id: \.self) { unit in
                                Text(unit.rawValue)
                            }
                        }
                        .labelsHidden()
                        
                        Image(systemName: "multiply")
                        
                        TextField("Amount", value: $amount, format: .number)
                            .keyboardType(.decimalPad)
                        
                        Image(systemName: "equal")
                        
                        Text("\(strength * amount, format: .number) \(unit.rawValue)")
                        
                    }
                    
                    VStack {
                        Toggle(isOn: $isGiven) {
                            Text("Given on:")
                        }
                        .onTapGesture(perform: changeToggle)
                        
                        HStack {
                            DatePicker("Please enter a date", selection: $dateGiven) // Date medicine is given.
                                .labelsHidden()
                            Spacer()
                        }
                    }
                    
                    VStack {
                        Toggle(isOn: $isSkipped) {
                            Text("Skipped On:")
                        }
                        .onTapGesture(perform: changeToggle)
                        
                        HStack {
                            DatePicker("Please enter a date", selection: $dateSkipped) // Date medicine is skipped.
                                .labelsHidden()
                            Spacer()
                        }
                    }
                    
                    TextField("Instructions", text: $instruction)
                }
            }
            .navigationTitle("Add Medicine")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                        print("The AddMedicineView (.sheet) has been dismissed by pressing the 'Cancel'-button.")
                    }
                }
                
                ToolbarItem {
                    Button("Save") {
                        // Action
                        addMedicine() // Calls the addMedicine()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
// MARK: - Functions for this View
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
    
    private func addMedicine() {
        withAnimation {
            patient.addToMedicine(
                Medicine(
                    date: date,
                    dateGiven: dateGiven,
                    datePrescriptionIsEnding: datePrescriptionIsEnding,
                    dateSkipped: dateSkipped,
                    name: name,
                    form: form.name,
                    frequency: frequency,
                    strength: strength,
                    unit: unit.rawValue,
                    amount: amount,
                    instruction: instruction,
                    isGiven: isGiven,
                    isPrescripted: isPrescripted,
                    isSkipped: isSkipped,
                    context: viewContext)) //_ = Medicine(date: date, name: name, context: viewContext)
            
            PersistenceController.shared.save() // Saves the patient.
           // print("Patient: \(name) \(familyName) \(swedishSocialSecurityNumber) adds on the list.")
           dismiss()
           // print("The AddLawView (.sheet) has been dismissed by pressing the 'Save'-button.")
        }
    }
}

struct AddMedicineView_Previews: PreviewProvider {
    static var previews: some View {
        AddMedicineView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
