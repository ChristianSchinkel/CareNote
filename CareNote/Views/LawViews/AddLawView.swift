//
//  AddLawView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-09.
//

import SwiftUI

struct AddLawView: View {
    @Environment(\.managedObjectContext) private var viewContext
    /// Calls the environment to dismiss a view or the actual sheet.
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var patient: Patient
    
    
// MARK: - local state properties for the sheet
    @State private var date = Date.now
    @State private var name = ""
    @State private var paragraph = ""
    
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
                        TextField("Law", text: $name)
                        
                        Divider()
                        
                        TextField("Paragraph", text: $paragraph)
                    }
                    .navigationTitle("Add Law")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                dismiss()
                                print("The AddLawView (.sheet) has been dismissed by pressing the 'Cancel'-button.")
                            }
                        }
                        
                        ToolbarItem {
                            Button("Save") {
                                // Action
                                addLaw() // Calls the addLaw()
                            }
                            .disabled(name.isEmpty)
                        }
                    }
                }
            }
        }
    }
// MARK: - Functions for this View:
    private func addLaw() {
        withAnimation {
            patient.addToLaw(Law(date: date, name: name, paragraph: paragraph, context: viewContext)) //_ = Law(date: date, name: name, paragraph: paragraph, context: viewContext)
            PersistenceController.shared.save() // Saves the patient.
           // print("Patient: \(name) \(familyName) \(swedishSocialSecurityNumber) adds on the list.")
           dismiss()
           // print("The AddLawView (.sheet) has been dismissed by pressing the 'Save'-button.")
        }
    }
}

struct AddLawView_Previews: PreviewProvider {
    static var previews: some View {
        AddLawView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
