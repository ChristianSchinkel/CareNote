//
//  AddMedicalTaskView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct AddMedicalTaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    /// Calls the environment to dismiss a view or the actual sheet.
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var patient: Patient
    
// MARK: - local state properties for the sheet
    @State private var date = Date.now
    @State private var name = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    HStack {
                        DatePicker("Please enter a date", selection: $date)
                            .labelsHidden()
                        Spacer()
                    }
                    HStack {
                        TextField("MedicalTask", text: $name)
                    }
                    .navigationTitle("Add MedicalTask")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                dismiss()
                                print("The AddMedicalTaskView (.sheet) has been dismissed by pressing the 'Cancel'-button.")
                            }
                        }
                        
                        ToolbarItem {
                            Button("Save") {
                                // Action
                                addMedicalTask() // Calls the addMedicine()
                            }
                            .disabled(name.isEmpty)
                        }
                    }
                }
            }
        }
    }
// MARK: - Functions for this View:
    private func addMedicalTask() {
        withAnimation {
            patient.addToMedicalTask(MedicalTask(date: date, name: name, context: viewContext)) //_ = MedicalTask(date: date, name: name, context: viewContext)
            PersistenceController.shared.save() // Saves the patient.
           // print("Patient: \(name) \(familyName) \(swedishSocialSecurityNumber) adds on the list.")
           dismiss()
           // print("The AddLawView (.sheet) has been dismissed by pressing the 'Save'-button.")
        }
    }
}

struct AddMedicalTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddMedicalTaskView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
