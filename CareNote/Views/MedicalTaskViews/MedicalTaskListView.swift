//
//  MedicalTaskListView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct MedicalTaskListView: View {
    @ObservedObject var patient: Patient
    
// MARK: - Boolean: showingLawAddView
    @State private var showingAddMedicalTaskView = false // by default the AddMedicalTaskView isn't presented.
    
    var body: some View {
        List {
            ForEach(patient.medicalTaskArray) { medicalTask in
                NavigationLink {
                    MedicalTaskDetailView(medicalTask: medicalTask) // Destination
                } label: {
                    MedicalTaskRowView(patient: patient, medicalTask: medicalTask) // Label in the List
                }
            }
            .onDelete(perform: deleteMedicalTask)
        }
        .navigationBarTitle("MedicalTask")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            
            ToolbarItem {
                Button(action: showAddMedicalTaskView) {
                    Label("Add MedicalTask", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddMedicalTaskView) {
            AddMedicalTaskView(patient: patient)
        }
    }
// MARK: - Functions for this View
    private func showAddMedicalTaskView() {
        showingAddMedicalTaskView = true
        print("plus-Button was pressed and boolean changed")
    }
    
    private func deleteMedicalTask(offsets: IndexSet) {
        withAnimation {
            MedicalTask.delete(at: offsets, for: Array(patient.medicalTaskArray))
            PersistenceController.shared.save()
        }
    }
}

struct MedicalTaskListView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalTaskListView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
