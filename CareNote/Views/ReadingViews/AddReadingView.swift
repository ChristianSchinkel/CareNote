//
//  AddReadingView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct AddReadingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    /// Calls the environment to dismiss a view or the actual sheet.
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var patient: Patient
    
// MARK: local state properties for the sheet
    @State private var date = Date.now
    @State private var unit = ""
    @State private var amount = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        DatePicker("Please enter a date", selection: $date)
                            .labelsHidden()
                        Spacer()
                    }
                    HStack {
                        TextField("Amount", text: $amount)
                        
                        Divider()
                        
                        TextField("Unit", text: $unit)
                    }
                    .navigationTitle("Add Reading")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                dismiss()
                                print("The AddReadingView (.sheet) has been dismissed by pressing the 'Cancel'-button.")
                            }
                        }
                        
                        ToolbarItem {
                            Button("Save") {
                                // Action
                                addReading() // Calls the addReading()
                            }
                            .disabled(unit.isEmpty)
                        }
                    }
                }
            }
        }
    }
// MARK: - Functions for this View
    private func addReading() {
        withAnimation {
            patient.addToReading(Reading(amount: Double(amount) ?? 0.0, date: date, unit: unit, context: viewContext)) //_ = Reading(amount: amount, date: date, unit: unit, context: viewContext)
            PersistenceController.shared.save() // Saves the patient.
           // print("Patient: \(name) \(familyName) \(swedishSocialSecurityNumber) adds on the list.")
           dismiss()
           // print("The AddReadingView (.sheet) has been dismissed by pressing the 'Save'-button.")
        }
    }
}

struct AddReadingView_Previews: PreviewProvider {
    static var previews: some View {
        AddReadingView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
