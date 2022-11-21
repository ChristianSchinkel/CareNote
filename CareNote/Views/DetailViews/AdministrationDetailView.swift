//
//  AdministrationDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-11-17.
//

import SwiftUI

struct AdministrationDetailView: View {
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
// MARK: - Functions for this View:
//    /// Toggles the bolean of the toggles "isSkipped" and "isGiven"
//    private func changeToggle() {
//        if isSkipped == false {
//            if isGiven == true {
//                isGiven.toggle()
//            }
//        } else if isGiven == false {
//            isSkipped.toggle()
//        }
//    }
}

struct AdministrationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AdministrationDetailView(medicine: Medicine.example(context: PersistenceController.preview.container.viewContext))
    }
}
