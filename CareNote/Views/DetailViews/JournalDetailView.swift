//
//  JournalDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-15.
//

import SwiftUI

struct JournalDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var journal: Journal
    
    var body: some View {
            VStack {
                HStack {
                    DatePicker("Please enter a date", selection: $journal.date)
                        .labelsHidden()
                    Spacer()
                }
               // ScrollView {
                    TextEditor(text: $journal.text)
               // }
                
            }
            .padding()
            
            .navigationTitle("\(journal.date.formatted(date: .numeric, time: .complete))")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Action
                        PersistenceController.shared.save() // Saves the viewContent.
                        dismiss() // Goes to the viewInstance above (Journaltext-list).
                    }
                }
        }
    }
}

struct JournalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        JournalDetailView(journal: Journal.example(context: PersistenceController.preview.container.viewContext))
    }
}
