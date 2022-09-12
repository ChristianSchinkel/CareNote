//
//  LawRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-09.
//

import SwiftUI

struct LawRowView: View {
    @ObservedObject var patient: Patient
    @ObservedObject var law: Law
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(law.name), \(law.paragraph)")
            }
            .font(.headline)
            .padding(.trailing)
            HStack {
                Text("\(law.date, format: .dateTime)")
                    .font(.caption)
                    .padding(.trailing)
            }
        }
    }
}

struct LawRowView_Previews: PreviewProvider {
    static var previews: some View {
        LawRowView(patient: Patient.example(context: PersistenceController.preview.container.viewContext), law: Law.example(context: PersistenceController.preview.container.viewContext))
    }
}
