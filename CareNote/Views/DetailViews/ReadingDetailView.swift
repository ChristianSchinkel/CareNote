//
//  ReadingDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct ReadingDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var reading: Reading
    
    var body: some View {
        VStack {
            Text("\(reading.amount, format: .number) \(reading.unit)")
            Text("\(reading.date, format: .dateTime)")
        }
    }
}

struct ReadingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingDetailView(reading: Reading.example(context: PersistenceController.preview.container.viewContext))
    }
}
