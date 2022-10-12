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
    
    @State private var selectedName = ""
    @State private var selectedForm = ""
    @State private var selectedUnit = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Text("\(selectedName)")
                    Text("\(selectedForm)")
                    Text("\(selectedUnit)")
                    Picker(selection: $selectedForm, label: Text("MedicinForm")) {
                        ForEach(Care.Medicine.Form.allCases) { form in
                            Text(form.rawValue.capitalized).tag(form.rawValue.capitalized)
                        }
                    }
                }
                .onAppear {
                    selectedName = medicine.name
                    selectedForm = medicine.form
                    selectedUnit = medicine.unit
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        medicine.form = selectedForm.capitalized
                        print("edited my medicine to \(medicine.form)")
                        PersistenceController.shared.save()
                        
                        dismiss()
                    }
                }
            }
        }
    }
}

struct MedicineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineDetailView(medicine: Medicine.example(context: PersistenceController.preview.container.viewContext))
    }
}
