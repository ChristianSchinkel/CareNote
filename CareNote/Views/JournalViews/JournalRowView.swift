//
//  JournalRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-15.
//

import SwiftUI

struct JournalRowView: View {
    @ObservedObject var patient: Patient
    @ObservedObject var journal: Journal
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(journal.date, format: .dateTime)")
                Text("Journal-entry")
            }
            .font(.headline)
            .padding(.trailing)
            HStack {
                Text("\(journal.text)")
                    .font(.caption)
                    .padding(.trailing)
            }
        }
    }
// MARK: - Functions for this View:
}

struct JournalRowView_Previews: PreviewProvider {
    static var previews: some View {
        JournalRowView(patient: Patient.example(context: PersistenceController.preview.container.viewContext), journal: Journal.example(context: PersistenceController.preview.container.viewContext))
    }
}
