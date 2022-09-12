//
//  MedicalTaskRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct MedicalTaskRowView: View {
    @ObservedObject var patient: Patient
    @ObservedObject var medicalTask: MedicalTask
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(medicalTask.name)")
                .font(.headline)
                .padding(.trailing)
            
            Text("\(medicalTask.date, format: .dateTime)")
                .font(.caption)
                .padding(.trailing)
        }
    }
}

struct MedicalTaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalTaskRowView(patient: Patient.example(context: PersistenceController.preview.container.viewContext), medicalTask: MedicalTask.example(context: PersistenceController.preview.container.viewContext))
    }
}
