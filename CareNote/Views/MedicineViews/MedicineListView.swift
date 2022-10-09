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
    @State private var administrationStatus: Care.Medicine.AdministrationStatus = .prescripted
    
    var body: some View {
        VStack {
            // TODO: Make this picker changing witch list-option should be shown - Prescripted medicine, given medicine and skipped medicine.
            Picker(selection: $administrationStatus, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                Text(Care.Medicine.AdministrationStatus.prescripted.rawValue.capitalized).tag(Care.Medicine.AdministrationStatus.prescripted)
                Text(Care.Medicine.AdministrationStatus.given.rawValue.capitalized).tag(Care.Medicine.AdministrationStatus.given)
                Text(Care.Medicine.AdministrationStatus.skipped.rawValue.capitalized).tag(Care.Medicine.AdministrationStatus.skipped)
            }
            .pickerStyle(.segmented)
            
            
            switch administrationStatus {
            case .prescripted:
                List {
                    ForEach(patient.medicineArray.filter({ $0.isPrescripted })) { medicine in
                        NavigationLink {
                            MedicineDetailView(medicine: medicine)  // Destination
                        } label: {
                            MedicineRowView(patient: patient, medicine: medicine) // Label in the List
                        }
                    }
                    .onDelete(perform: deleteMedicine)
                }
                
            case .given:
                List {
                    ForEach(patient.medicineArray.filter({ $0.isGiven })) { medicine in
                        NavigationLink {
                            MedicineDetailView(medicine: medicine)  // Destination
                        } label: {
                            MedicineRowView(patient: patient, medicine: medicine) // Label in the List
                        }
                    }
                    .onDelete(perform: deleteMedicine)
                }
                
            case .skipped:
                List {
                    ForEach(patient.medicineArray.filter({ $0.isSkipped })) { medicine in
                        NavigationLink {
                            MedicineDetailView(medicine: medicine)  // Destination
                        } label: {
                            MedicineRowView(patient: patient, medicine: medicine) // Label in the List
                        }
                    }
                    .onDelete(perform: deleteMedicine)
                }
                
            case .taken:
                List {
                    ForEach(patient.medicineArray.filter({ $0.isGiven })) { medicine in
                        NavigationLink {
                            MedicineDetailView(medicine: medicine)  // Destination
                        } label: {
                            MedicineRowView(patient: patient, medicine: medicine) // Label in the List
                        }
                    }
                    .onDelete(perform: deleteMedicine)
                }
                
            case .none:
                Text("No meds here")
            }
            
        } // MARK: Outer VStack
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
