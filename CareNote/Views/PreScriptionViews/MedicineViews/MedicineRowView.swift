//
//  MedicineRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-11-17.
//

import SwiftUI

struct MedicineRowView: View {
    @ObservedObject var patient: Patient
    @ObservedObject var medicine: Medicine
    
    var body: some View {
        HStack {
            Text("\(medicine.hasPlannedDate, format: .dateTime)")
            
            VStack(alignment: .leading) {
                HStack {
                    Text(medicine.name)
                    Text(medicine.strengthValue, format: .number)
                    Text(medicine.strengthValueUnit)
                    
                    Image(systemName: "multiply")
                    
                    Text(medicine.amountValue, format: .number)
                    Text(medicine.amountValueUnit)
                }
                .font(.headline)
                
                HStack {
                    Text(medicine.activeSubstance)
                    Text(medicine.form)
                        .font(.subheadline)
                }
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.leading)
            }
        }
    }
}

struct MedicineRowView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineRowView(patient: Patient.example(context: PersistenceController.preview.container.viewContext), medicine: Medicine.example(context: PersistenceController.preview.container.viewContext))
    }
}
