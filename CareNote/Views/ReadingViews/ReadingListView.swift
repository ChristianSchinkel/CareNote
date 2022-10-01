//
//  ReadingListView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-09.
//

import SwiftUI

struct ReadingListView: View {
    @ObservedObject var patient: Patient
    
// MARK: - Boolean: showingLawAddView
    @State private var showingAddReadingView = false // by default the AddLawView isn't presented.
    
    var body: some View {
            List {
                ForEach(patient.readingArray) { reading in
                    NavigationLink {
                        ReadingDetailView(reading: reading) // Destination
                    } label: {
                        ReadingRowView(patient: patient, reading: reading) // Label in the List
                    }
                }
                .onDelete(perform: deleteReading)
            }
            .navigationTitle("Reading")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem {
                    Button(action: showAddReadingView) {
                        Label("Add Reading", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddReadingView) {
                AddReadingView(patient: patient)
        }
    }
// MARK: - Funktions for this View
    private func showAddReadingView() {
        showingAddReadingView = true
        print("plus-Button was pressed and boolean changed")
    }
    
    private func deleteReading(offsets: IndexSet) {
        withAnimation {
            Reading.delete(at: offsets, for: Array(patient.readingArray))
            PersistenceController.shared.save()
        }
    }
}

struct ReadingListView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingListView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
