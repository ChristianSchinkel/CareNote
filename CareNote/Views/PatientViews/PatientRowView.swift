//
//  PatientRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-14.
//

import SwiftUI

struct PatientRowView: View {
    @ObservedObject var patient: Patient
    
    var body: some View {
        HStack {
            Text(patient.name)
            Text(patient.familyName)
            Text(patient.swedishSocialSecurityNumber)
        }
    }
}

struct PatientRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        PatientRowView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
