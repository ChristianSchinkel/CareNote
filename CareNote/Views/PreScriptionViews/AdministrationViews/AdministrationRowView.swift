//
//  AdministrationRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-11-18.
//

import SwiftUI

struct AdministrationRowView: View {
    @ObservedObject var patient: Patient
    @ObservedObject var medicine: Medicine
    
    var body: some View {
        HStack {
            medicine.isGivenOrTaken == false ? Image(systemName: "circle") : Image(systemName: "checkmark.circle")
            
            VStack(alignment: .leading) {
                Text("\(medicine.hasPlannedDate, format: .dateTime)")
                    .font(.callout)
                    .bold()
                    .foregroundColor(.secondary)
                
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
                        
                        medicine.isGivenOrTaken == false && medicine.isSkipped == false ? Text("No Date") : Text("\(lastDateTimeStamp()!, format: .dateTime)")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.leading)
                }
            }
        }
    }
    // MARK: - Functions for this View:
    private func lastDateTimeStamp() -> Date? {
        guard !medicine.DateTimeStampArray.isEmpty else {
            
            return Date.now
        }
        
        return medicine.DateTimeStampArray.last?.date
    }
}

struct AdministrationRowView_Previews: PreviewProvider {
    static var previews: some View {
        AdministrationRowView(patient: Patient.example(context: PersistenceController.preview.container.viewContext), medicine: Medicine.example(context: PersistenceController.preview.container.viewContext))
    }
}
