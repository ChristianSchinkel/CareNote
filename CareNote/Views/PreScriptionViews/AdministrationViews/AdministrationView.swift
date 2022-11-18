//
//  AdministrationView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-11-06.
//

import SwiftUI

struct AdministrationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var patient: Patient
//    @ObservedObject var medicine: Medicine
    
    var body: some View {
        AdministrationListView(patient: patient)
    }
}

struct AdministrationView_Previews: PreviewProvider {
    static var previews: some View {
        AdministrationView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))//, medicine: Medicine.example(context: PersistenceController.preview.container.viewContext))
    }
}
