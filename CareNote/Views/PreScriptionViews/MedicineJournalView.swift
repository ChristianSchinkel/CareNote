//
//  MedicineJournalView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-11-18.
//

import SwiftUI

struct MedicineJournalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var patient: Patient
//    @ObservedObject var medicine: Medicine
    
    var options = ["Prescription", "Administration"]
    @State private var selectedOption = "Prescription"
    
    var body: some View {
        VStack {
            Picker(selection: $selectedOption, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                ForEach(options, id: \.self) { option in
                    Text(option)
                }
            }
            .pickerStyle(.segmented)
            
            if selectedOption == "Prescription" {
                PreScriptionListView(patient: patient)
            } else {
                AdministrationListView(patient: patient)
            }
        }
    }
}

struct MedicineJournalView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineJournalView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))//, medicine: Medicine.example(context: PersistenceController.preview.container.viewContext))
    }
}
