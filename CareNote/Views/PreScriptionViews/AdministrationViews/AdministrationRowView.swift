//
//  AdministrationRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-11-17.
//

import SwiftUI

struct AdministrationRowView: View {
    @ObservedObject var medicine: Medicine
    
    var body: some View {
        MedicineRowView(medicine: medicine)
    }
}

struct AdministrationRowView_Previews: PreviewProvider {
    static var previews: some View {
        AdministrationRowView(medicine: Medicine.example(context: PersistenceController.preview.container.viewContext))
    }
}
