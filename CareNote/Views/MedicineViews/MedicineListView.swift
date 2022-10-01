//
//  MedicineListView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct MedicineListView: View {
    @ObservedObject var patient: Patient
    
// MARK: - Boolean: showingLawAddView
    @State private var showingAddMedicineView = false // by default the AddMedicineView isn't presented.
    
    var body: some View {
            List {
                ForEach(patient.medicineArray) { medicine in
                    NavigationLink {
                        MedicineDetailView(medicine: medicine) // Destination
                    } label: {
                        MedicineRowView(patient: patient, medicine: medicine) // Label in the List
                    }
                }
                .onDelete(perform: deleteMedicine)
            }
            .navigationBarTitle("Medicine")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem {
                    Button(action: showAddMedicineView) {
                        Label("Add Medicine", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddMedicineView) {
                AddMedicineView(patient: patient)
        }
    }
// MARK: - Functions for this View
    private func showAddMedicineView() {
        showingAddMedicineView = true
        print("plus-Button was pressed and boolean changed")
    }
    
    private func deleteMedicine(offsets: IndexSet) {
        withAnimation {
            Medicine.delete(at: offsets, for: Array(patient.medicineArray))
            PersistenceController.shared.save()
        }
    }
}

struct MedicineListView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineListView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
