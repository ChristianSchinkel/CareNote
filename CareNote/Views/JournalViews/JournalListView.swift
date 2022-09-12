//
//  JournalListView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-15.
//

import SwiftUI

struct JournalListView: View {
    @ObservedObject var patient: Patient

// MARK: - Boolean: showingJournalAddView
    @State private var showingAddJournalEntryView = false // by default the AddJournalEntryView isn't presented.
    
    var body: some View {
            List {
                ForEach(patient.journalArray) { journal in
                    NavigationLink {
                        JournalDetailView(journal: journal) // Destination
                    } label: {
                        JournalRowView(patient: patient, journal: journal) // Text("\(journal.date, format: .dateTime) Journal-entry") // Label in the List
                    }
                }
                .onDelete(perform: deleteJournalEntry)
            }
            .navigationTitle("Journaltext")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem {
                    Button(action: showAddJournalEntryView) {
                        Label("Add Journal-entry", systemImage: "square.and.pencil")
                    }
                }
            }
            .sheet(isPresented: $showingAddJournalEntryView) {
                AddJournalEntryView(patient: patient)
            }
            // Text("Select a journal-entry") // This view appears on iPads in the middle of the screen, if no journalEntry was selected.
    }
// MARK: - Functions for this View
    private func showAddJournalEntryView() {
        showingAddJournalEntryView = true
        print("squareAndPencil-Button was pressed and boolean changed")
    }
    
    private func deleteJournalEntry(offsets: IndexSet) {
        withAnimation {
            Journal.delete(at: offsets, for: Array(patient.journalArray))
            PersistenceController.shared.save()
        }
    }
}

struct JournalListView_Previews: PreviewProvider {
    static var previews: some View {
        JournalListView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
