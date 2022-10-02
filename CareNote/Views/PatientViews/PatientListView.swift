//
//  PatientListView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-14.
//

import SwiftUI
import CoreData

struct PatientListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(fetchRequest: Patient.fetch(), animation: .default)
    private var patients: FetchedResults<Patient>
// MARK: - Boolean: showingPatientAddView
    @State private var showingAddPatientView = false // by default the PatientAddSheet isn't presented.
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(patients) { patient in
                    NavigationLink {
                        PatientDetailView(patient: patient) // Destination
                    } label: {
                        PatientRowView(patient: patient) // Label in the list.
                    }
                }
                .onDelete(perform: deletePatient)
            }
            .navigationTitle("🏥Note")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem {
                    Button(action: showPatientAddView) {
                        Label("Add Patient", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddPatientView) {
                AddPatientView()
            }
            Text("Select a patient") // This view appears on iPads in the middle of the screen, if no patient was selected.
        }
    }
// MARK: - Functions for this View
    private func showPatientAddView() {
        showingAddPatientView = true
        print("Plus-Button was pressed and boolean changed")
    }
    
    private func deletePatient(offsets: IndexSet) {
        withAnimation {
            Patient.delete(at: offsets, for: Array(patients))
            PersistenceController.shared.save()
        }
    }
}

struct PatientListView_Previews: PreviewProvider {
    static var previews: some View {
        PatientListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
