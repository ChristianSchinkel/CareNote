//
//  MedicineListView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct PreScriptionListView: View {
    @ObservedObject var patient: Patient
    
    // MARK: - Boolean: showingLawAddView
    @State private var showingAddPreScriptionView = false // by default the AddMedicineView isn't presented.
    @State private var administrationStatus: Care.Medicine.AdministrationStatus = .prescripted
    @State private var chosenDate = Date.now
    
    var body: some View {
        VStack {
//            // TODO: Make this picker changing witch list-option should be shown - Prescripted medicine, given medicine and skipped medicine.
//            Picker(selection: $administrationStatus, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
//                Text(Care.Medicine.AdministrationStatus.prescripted.rawValue.capitalized).tag(Care.Medicine.AdministrationStatus.prescripted)
//                Text(Care.Medicine.AdministrationStatus.given.rawValue.capitalized).tag(Care.Medicine.AdministrationStatus.given)
//                Text(Care.Medicine.AdministrationStatus.skipped.rawValue.capitalized).tag(Care.Medicine.AdministrationStatus.skipped)
//            }
//            .pickerStyle(.segmented)
//            
//            DatePicker(selection: $chosenDate, label: { Text("Chosen date") })
//                .padding()
            
            List {
                ForEach(patient.preScriptionArray) { preScription in
                    NavigationLink {
                        PreScriptionDetailView(patient: patient, preScription: preScription) // Destination.
                    } label: {
                        PreScriptionRowView(patient: patient, preScription: preScription) // Label in the List.
                    }
                }
                .onDelete(perform: deletePreScription)
            }
            
        } // MARK: Outer VStack
        .navigationTitle("Medicine-Journal")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            
            ToolbarItem {
                Button(action: showAddPreScriptionView) {
                    Label("Add Prescription", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddPreScriptionView) {
            AddPreScriptionView(patient: patient)
        }
    }
// MARK: - Functions for this View:
    private func showAddPreScriptionView() {
        showingAddPreScriptionView = true
        print("plus-Button was pressed and boolean changed")
    }
    
    private func deletePreScription(offsets: IndexSet) {
        withAnimation {
            PreScription.delete(at: offsets, for: Array(patient.preScriptionArray))
            PersistenceController.shared.save()
        }
    }
}

struct PreScriptionListView_Previews: PreviewProvider {
    static var previews: some View {
        PreScriptionListView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
