//
//  MedicalTaskDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import SwiftUI

struct MedicalTaskDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var medicalTask: MedicalTask
    
    var body: some View {
        VStack {
            Text("\(medicalTask.name)")
            Text("\(medicalTask.date, format: .dateTime)")
        }
    }
}

struct MedicalTaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalTaskDetailView(medicalTask: MedicalTask.example(context: PersistenceController.preview.container.viewContext))
    }
}
