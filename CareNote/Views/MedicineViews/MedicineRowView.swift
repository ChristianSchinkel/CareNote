//
//  MedicineRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct MedicineRowView: View {
    @ObservedObject var patient: Patient
    @ObservedObject var medicine: Medicine
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(medicine.name) \(medicine.strength, format: .number) \(medicine.unit) x \(medicine.amount, format: .number) \(medicine.form)")
                .font(.headline)
                .padding(.trailing)
            
            Text("\(medicine.date, format: .dateTime)")
                .font(.caption)
                .padding(.trailing)
        }
    }
}

struct MedicineRowView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineRowView(patient: Patient.example(context: PersistenceController.preview.container.viewContext), medicine: Medicine.example(context: PersistenceController.preview.container.viewContext))
    }
}
