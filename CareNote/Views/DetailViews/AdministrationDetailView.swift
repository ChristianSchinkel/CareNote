//
//  AdministrationDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-11-17.
//

import SwiftUI

struct AdministrationDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    /// Calls the environment to dismiss a view or the actual sheet.
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var medicine: Medicine
    
    @State private var date: Date = Date.now
    @State private var amount: Double = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(medicine.name)
                Text(medicine.strengthValue, format: .number)
                Text(medicine.strengthValueUnit)
            }
            .bold()
            .font(.largeTitle)
            
            Text(medicine.form)
                .font(.title3)
            
            Divider()
            
            HStack {
                Spacer()
                
                TextField("Amount", value: $amount, format: .number)
                    .frame(maxWidth: 50)
                    .multilineTextAlignment(.trailing)
                Text(medicine.amountValueUnit)
                    .bold()
                
            }
            
            Divider()
            
            DatePicker(selection: $date, label: { Text("Time:") })
                .onAppear {
                    amount = medicine.amountValue
                    date = lastDateTimeStamp()!
                }
            
            
            Spacer()
            
            HStack {
                Button {
                    skipp()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(maxWidth: 150, maxHeight: 50)
                            .foregroundColor(.red)
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                Button {
                    giveOrTake()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(maxWidth: 150, maxHeight: 50)
                            .foregroundColor(.green)
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
// MARK: - Functions for this View:
    private func skipp() {
        medicine.isSkipped = true
        medicine.hasSkippedDate = date
        
        medicine.amountValue = amount
        medicine.addToDateTimeStamp(DateTimeStamp(date: date, isGivenOrTaken: false, isSkipped: true, context: viewContext))
        
        if medicine.isGivenOrTaken {
            medicine.isGivenOrTaken = false
        }
        PersistenceController.shared.save() // Saves the DateTimeStamp.
        dismiss()
    }
    private func giveOrTake() {
        medicine.isGivenOrTaken = true
        medicine.hasGivenOrTakenDate = date
        
        medicine.amountValue = amount
        medicine.addToDateTimeStamp(DateTimeStamp(date: date, isGivenOrTaken: true, isSkipped: false, context: viewContext))
        
        if medicine.isSkipped {
            medicine.isSkipped = false
        }
        PersistenceController.shared.save() // Saves the DateTimeStamp.
        dismiss()
    }
    
    private func lastDateTimeStamp() -> Date? {
        guard !medicine.DateTimeStampArray.isEmpty else {
            
            return Date.now
        }
        
        return medicine.DateTimeStampArray.last?.date
    }
}

struct AdministrationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AdministrationDetailView(medicine: Medicine.example(context: PersistenceController.preview.container.viewContext))
    }
}
