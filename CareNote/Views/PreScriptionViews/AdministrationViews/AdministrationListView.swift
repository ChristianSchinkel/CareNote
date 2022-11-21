//
//  AdministrationListView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-11-17.
//

import SwiftUI

struct AdministrationListView: View {
    @ObservedObject var patient: Patient
    
    var body: some View {
        VStack {
            List {
                ForEach(patient.medicineArray) { medicine in
                    NavigationLink {
                        AdministrationDetailView(medicine: medicine)
                    } label: {
                        AdministrationRowView(patient: patient, medicine: medicine)
                    }
                }
            }
        }
        .navigationTitle("Medicine-Journal")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AdministrationListView_Previews: PreviewProvider {
    static var previews: some View {
        AdministrationListView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
