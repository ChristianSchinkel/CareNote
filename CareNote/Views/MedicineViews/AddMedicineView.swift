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
    @State private var date = Date.now
    @State private var name = ""
    
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
                        TextField("medicineName", text: $name)
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
        }
    }
// MARK: - Functions for this View
    private func addMedicine() {
        withAnimation {
            patient.addToMedicine(Medicine(date: date, name: name, context: viewContext)) //_ = Medicine(date: date, name: name, context: viewContext)
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
