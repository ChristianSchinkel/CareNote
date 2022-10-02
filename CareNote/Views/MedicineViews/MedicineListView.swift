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
        VStack {
            // TODO: Make this picker changing witch list-option should be shown - Prescripted medicine, given medicine and skipped medicine.
            Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                Text("Prescripted").tag(1)
                Text("Given").tag(2)
                Text("Skipped").tag(3)
            }
            .pickerStyle(.segmented)
            
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
