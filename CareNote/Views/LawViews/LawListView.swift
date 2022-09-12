//
//  LawListView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-09.
//

import SwiftUI

struct LawListView: View {
    @ObservedObject var patient: Patient
    
// MARK: - Boolean: showingLawAddView
    @State private var showingAddLawView = false // by default the AddLawView isn't presented.
    
    var body: some View {
        List {
            ForEach(patient.lawArray) { law in
                NavigationLink {
                    LawDetailView(law: law) // Destination
                } label: {
                    LawRowView(patient: patient, law: law) // Label in the List
                }
            }
            .onDelete(perform: deleteLaw)
        }
        .navigationTitle("Law")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            
            ToolbarItem {
                Button(action: showAddLawView) {
                    Label("Add Law", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddLawView) {
            AddLawView(patient: patient)
        }
    }
// MARK: - Funktions for this View
    private func showAddLawView() {
        showingAddLawView = true
        print("plus-Button was pressed and boolean changed")
    }
    
    private func deleteLaw(offsets: IndexSet) {
        withAnimation {
            Law.delete(at: offsets, for: Array(patient.lawArray))
            PersistenceController.shared.save()
        }
    }
}

struct LawListView_Previews: PreviewProvider {
    static var previews: some View {
        LawListView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
