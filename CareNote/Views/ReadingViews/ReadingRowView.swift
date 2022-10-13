//
//  ReadingRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct ReadingRowView: View {
    @ObservedObject var patient: Patient
    @ObservedObject var reading: Reading
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(reading.amount, format: .number) \(reading.unit)")
            }
            .font(.headline)
            .padding(.trailing)
            HStack {
                Text("\(reading.date, format: .dateTime)")
                    .font(.caption)
                    .padding(.trailing)
            }
        }
    }
// MARK: - Functions for this View:
}

struct ReadingRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingRowView(patient: Patient.example(context: PersistenceController.preview.container.viewContext), reading: Reading.example(context: PersistenceController.preview.container.viewContext))
    }
}
