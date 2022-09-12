//
//  MedicineDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct MedicineDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var medicine: Medicine
    
    var body: some View {
        VStack {
            Text("\(medicine.name)")
            Text("\(medicine.date, format: .dateTime)")
        }
    }
}

struct MedicineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineDetailView(medicine: Medicine.example(context: PersistenceController.preview.container.viewContext))
    }
}
