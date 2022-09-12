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
    @State private var swedishSocialSecurityNumber = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("ID") {
                    TextField("Name", text: $name)
                    TextField("Family Name", text: $familyName)
                    TextField("ÅÅÅÅMMDDNNNN", text: $swedishSocialSecurityNumber)
                        .keyboardType(.numberPad)
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
                    .disabled(name.isEmpty || familyName.isEmpty || swedishSocialSecurityNumber.isEmpty)
                    
                }
            }
        }
    }
// MARK: - Functions for this View
    private func addPatient() {
        withAnimation {
            _ = Patient(familyName: familyName, name: name, swedishSocialSecurityNumber: swedishSocialSecurityNumber, context: viewContext)
            PersistenceController.shared.save() // Saves the patient.
            print("Patient: \(name) \(familyName) \(swedishSocialSecurityNumber) adds on the list.")
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
