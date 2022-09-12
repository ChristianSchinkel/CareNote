//
//  PatientDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-15.
//

import SwiftUI

struct PatientDetailView: View {
    @ObservedObject var patient: Patient
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .foregroundColor(Color.gray)
                .frame(width: 100, height: 100)
            HStack {
                // TODO: - add a button for changing name that opens a alert or a sheet there you can change name of patient OR make it a textfield instead.
                Text(patient.name)
                Text(patient.familyName)
            }
            .font(.largeTitle)
            
            Text(patient.swedishSocialSecurityNumber)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Divider()
            
            Form {
                Section("Journal") {
                    NavigationLink {
                        JournalListView(patient: patient)
                    } label: {
                        Text("Journaltext")
                    }
                    
                    NavigationLink {
                        MedicineListView(patient: patient)
                    } label: {
                        Text("Medicine-list")
                    }
                    
                    NavigationLink {
                        LawListView(patient: patient)
                    } label: {
                        Text("Law")
                    }
                    
                    NavigationLink {
                        ReadingListView(patient: patient)
                    } label: {
                        Text("Readings-list")
                    }
                }
                Section("Tasks") {
                    NavigationLink {
                        MedicalTaskListView(patient: patient)
                    } label: {
                        Text("Tasks")
                    }
                }
            }
        }
    }
}

struct PatientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PatientDetailView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
