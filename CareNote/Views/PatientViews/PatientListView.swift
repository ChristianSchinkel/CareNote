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
    
    private let SelectAPatient: LocalizedStringKey = "SelectAPatient" // localized string.
// MARK: - Boolean: showingPatientAddView
    @State private var showingAddPatientView = false // by default the PatientAddSheet isn't presented.
    @State private var showingAlertDeleteAllPatients = false // Showing an alert if you delete al patients.
    
    
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
            .alert("Important message", isPresented: $showingAlertDeleteAllPatients) {
                Button("Delete", role: .destructive) { deleteAllPatients() } // Deletes all items on the list.
                Button("Cancel", role: .cancel) { } // Cancel and hide the alert.
            } message: {
                Text("Please read this until you continue. \n You are going to delete all information stored in your lists.")
            }
            
            ZStack {
                Text(SelectAPatient)
                
                HStack {
                    Button(role: .destructive) {
                        showingAlertDeleteAllPatients = true // Showing the alert.
                    } label: {
                        Image(systemName: "trash")
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
            } // This view appears on iPads in the middle of the screen, if no patient was selected.
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
    
    private func deleteAllPatients() {
        withAnimation {
            patients.forEach(viewContext.delete)
            PersistenceController.shared.save()
            print("All Patiens are removed.")
        }
    }
}

struct PatientListView_Previews: PreviewProvider {
    static var previews: some View {
        PatientListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
