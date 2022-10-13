//
//  MedicineDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct MedicineDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var medicine: Medicine
    
    @State private var selectedDatePrescriptionIsStarting = Date.now // Date of Prescription.
    @State private var selectedDatePrescriptionIsEnding = Date.distantFuture // Date Prescription is ending.
    @State private var selectedDateGiven = Date.now // Date the medicine is given.
    @State private var selectedDateSkipped = Date.now // Date the medicine is skipped.
    @State private var selectedName = ""
    @State private var selectedForm = ""
    @State private var selectedFrequency = ""
    @State private var selectedStrength = 1.0
    @State private var selectedUnit = ""
    @State private var selectedAmount = 1.0
    @State private var selectedInstruction = "" // additional instructions for administration.
    @State private var selectedIsPrescripted = false
    @State private var selectedIsGiven = false
    @State private var selectedIsSkipped = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    VStack {
                        Toggle(isOn: $selectedIsPrescripted) {
                            Text("Prescripted On:")
                        }
                        HStack {
                            DatePicker(selection: $selectedDatePrescriptionIsStarting, label: { Text("Please enter a date") })
                                .labelsHidden()
                            Spacer()
                        }
                        HStack {
                            DatePicker("Ending On:", selection: $selectedDatePrescriptionIsEnding)
                        }
                        
                        TextField("Medicine name", text: $selectedName)
                        
                        Picker(selection: $selectedForm, label: Text("Medicine Form")) {
                            ForEach(Care.Medicine.Form.allCases) { form in
                                Text(form.rawValue.capitalized).tag(form.rawValue.capitalized)
                            }
                        }
                        
                        TextField("Medication frequency", text: $selectedFrequency)
                        
                        HStack {
                            TextField("Medicine Strength", value: $selectedStrength, format: .number)
                                .keyboardType(.decimalPad)
                            
                            Picker(selection: $selectedUnit, label: Text("MedicinUnit")) {
                                ForEach(Care.Medicine.Unit.allCases) { unit in
                                    Text(unit.rawValue).tag(unit.rawValue)
                                }
                            }
                            .labelsHidden()
                            
                            Image(systemName: "multiply")
                            
                            TextField("Amount", value: $selectedAmount, format: .number)
                                .keyboardType(.decimalPad)
                            
                            Image(systemName: "equal")
                            
                            Text("\(selectedStrength * selectedAmount, format: .number) \(selectedUnit)")
                        }
                        
                        VStack {
                            Toggle(isOn: $selectedIsGiven) {
                                Text("Given on:")
                            }
                            .onTapGesture(perform: changeToggle)
                            
                            HStack {
                                DatePicker("Please enter a date", selection: $selectedDateGiven) // Date medicine is given.
                                    .labelsHidden()
                                Spacer()
                            }
                        }
                        
                        VStack {
                            Toggle(isOn: $selectedIsSkipped) {
                                Text("Skipped On:")
                            }
                            .onTapGesture(perform: changeToggle)
                            
                            HStack {
                                DatePicker("Please enter a date", selection: $selectedDateSkipped) // Date medicine is skipped.
                                    .labelsHidden()
                                Spacer()
                            }
                        }
                        
                        TextField("Instructions", text: $selectedInstruction)
                    }
                }
                .onAppear {
                    selectedDatePrescriptionIsStarting = medicine.datePrescriptionIsStarting
                    selectedDatePrescriptionIsEnding = medicine.datePrescriptionIsEnding
                    selectedDateGiven = medicine.dateGiven
                    selectedDateSkipped = medicine.dateSkipped
                    selectedName = medicine.name
                    selectedForm = medicine.form
                    selectedFrequency = medicine.frequency
                    selectedStrength = medicine.strength
                    selectedUnit = medicine.unit
                    selectedAmount = medicine.amount
                    selectedInstruction = medicine.instruction
                    selectedIsPrescripted = medicine.isPrescripted
                    selectedIsGiven = medicine.isGiven
                    selectedIsSkipped = medicine.isSkipped
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        medicine.datePrescriptionIsStarting = selectedDatePrescriptionIsStarting
                        medicine.datePrescriptionIsEnding = selectedDatePrescriptionIsEnding
                        medicine.dateGiven = selectedDateGiven
                        medicine.dateSkipped = selectedDateSkipped
                        medicine.name = selectedName
                        medicine.form = selectedForm.capitalized // TODO: update-funktion behöver skapas.
                        medicine.frequency = selectedFrequency
                        medicine.strength = selectedStrength
                        medicine.unit = selectedUnit
                        medicine.amount = selectedStrength
                        medicine.instruction = selectedInstruction
                        medicine.isPrescripted = selectedIsPrescripted
                        medicine.isGiven = selectedIsGiven
                        medicine.isSkipped = selectedIsSkipped
                        
                        print("Edited medicine to \(medicine.form)")
//                        PersistenceController.shared.save()
                        
                        dismiss()
                    }
                }
            }
            .navigationTitle("Edit Medicine")
        }
    }
// MARK: - Functions for this View:
    /// Toggles the bolean of the toggles "selectedIsSkipped" and "selectedIsGiven"
    private func changeToggle() {
        if selectedIsSkipped == false {
            if selectedIsGiven == true {
                selectedIsGiven.toggle()
            }
        } else if selectedIsGiven == false {
            selectedIsSkipped.toggle()
        }
    }
}

struct MedicineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineDetailView(medicine: Medicine.example(context: PersistenceController.preview.container.viewContext))
    }
}
