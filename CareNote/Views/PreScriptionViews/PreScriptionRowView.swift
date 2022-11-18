//
//  MedicineRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct PreScriptionRowView: View {
    @ObservedObject var patient: Patient
    @ObservedObject var preScription: PreScription
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(preScription.medicineName) \(preScription.medicineStrengthValue, format: .number) \(preScription.medicineStrengthValueUnit) x \(preScription.medicineDoseAmount, format: .number) \(preScription.medicineForm)")
                .font(.headline)
                .padding(.trailing)
            
            HStack {
                Text("\(preScription.treatmentDurationStartDate, format: .dateTime)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                .padding(.trailing)
                
                Text("\(preScription.treatmentDurationEndDate, format: .dateTime)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                .padding(.trailing)
            }
        }
    }
// MARK: - Functions for this View:
}

struct PreScriptionRowView_Previews: PreviewProvider {
    static var previews: some View {
        PreScriptionRowView(patient: Patient.example(context: PersistenceController.preview.container.viewContext), preScription: PreScription.example(context: PersistenceController.preview.container.viewContext))
    }
}
