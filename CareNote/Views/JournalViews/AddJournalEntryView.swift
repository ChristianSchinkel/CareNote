//
//  AddJournalEntryView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-15.
//

import SwiftUI

struct AddJournalEntryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    /// Calls the environment to dismiss a view or the actual sheet.
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var patient: Patient
    
// MARK: local state properties for the sheet
    @State private var date = Date.now
    @State private var text = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    HStack {
                        DatePicker("Please enter a date", selection: $date)
                            .labelsHidden()
                        Spacer()
                    }
                    TextEditor(text: $text)
                }
                .navigationTitle("Add Journal-Entry")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            dismiss()
                            print("The AddJournalEntryView (.sheet) has been dismissed by pressing the 'Cancel'-button.")
                        }
                    }
                    
                    ToolbarItem {
                        Button("Save") {
                            // Action
                            addJournal() // Calls the addJournal()
                        }
                        .disabled(text.isEmpty)
                    }
                }
            }
        }
    }
    
// MARK: - Functions for this View:
    private func addJournal() {
        withAnimation {
            patient.addToJournal(Journal(date: date, text: text, context: viewContext)) //_ = Journal(date: date, text: text, context: viewContext)
            PersistenceController.shared.save() // Saves the patient.
           // print("Patient: \(name) \(familyName) \(swedishSocialSecurityNumber) adds on the list.")
           dismiss()
           // print("The AddJournalEntryView (.sheet) has been dismissed by pressing the 'Save'-button.")
        }
    }
}

struct AddJournalEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddJournalEntryView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
