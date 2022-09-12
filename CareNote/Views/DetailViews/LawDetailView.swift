//
//  LawDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-09.
//

import SwiftUI

struct LawDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var law: Law
    
    var body: some View {
        VStack {
            Text("\(law.name) \(law.paragraph)")
            Text("\(law.date, format: .dateTime)")
        }
    }
}

struct LawDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LawDetailView(law: Law.example(context: PersistenceController.preview.container.viewContext))
    }
}
