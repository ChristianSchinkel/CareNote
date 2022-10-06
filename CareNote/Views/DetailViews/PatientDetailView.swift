//
//  PatientDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-15.
//

import SwiftUI

struct PatientDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var patient: Patient
    
    @State private var showingOptions = false
    @State private var patientIsAwakeOrSleeping = ""
    @State private var showingChangePatientName = false
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .foregroundColor(Color.gray)
                .frame(width: 100, height: 100)
            HStack {
                // TODO: - add a button for changing name that opens an alert there you can change name of patient OR make it a textfield instead.
                Text(patient.name)
                Text(patient.familyName)
            }
            .font(.largeTitle)
            .onLongPressGesture() {
                showingChangePatientName = true
            }
            .alert("Rename Patients Identity", isPresented: $showingChangePatientName) {
                VStack {
                    TextField("Name", text: $patient.name)
                    TextField("FamilyName", text: $patient.familyName)
                    HStack {
                        TextField("ÅÅÅÅMMDD-NNNN", text: $patient.swedishSocialSecurityNumber)
                    }
                }
                Button("Change", role: .destructive) {
                    PersistenceController.shared.save() // Saves the viewContent.
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Important you are going to change patients names and identities!")
            }
            
            Text(patient.swedishSocialSecurityNumber)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Divider()
            
            Form {
                HStack {
                    Button("\(Care.Patient.ActivityStatus.awake.rawValue.capitalized) or \(Care.Patient.ActivityStatus.sleeping.rawValue.capitalized)?") {
                        showingOptions = true // Opens a menu
                    }
                    .confirmationDialog("Select an option", isPresented: $showingOptions, titleVisibility: .visible) {
                        Button(Care.Patient.ActivityStatus.awake.rawValue.capitalized) {
                            patientIsAwakeOrSleeping = Care.Patient.ActivityStatus.awake.rawValue.capitalized
                            addJournalPatientStatus() // Call the function declared down.. to add the chosen option.
                            
                        }
                        
                        Button(Care.Patient.ActivityStatus.sleeping.rawValue.capitalized) {
                            patientIsAwakeOrSleeping = Care.Patient.ActivityStatus.sleeping.rawValue.capitalized
                            addJournalPatientStatus() // Call the function declared down.. to add the chosen option.
                        }
                }
                    Text("\(patientIsAwakeOrSleeping)")
                }
                
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
// MARK: - Functions for this View
    /// Adds one of the options to the journal.
    private func addJournalPatientStatus() {
        // DO something
        let text = "The patient is \(patientIsAwakeOrSleeping.lowercased())."
        patient.addToJournal(Journal(date: Date.now, text: text, context: viewContext)) //_ = Journal(date: date, text: text, context: viewContext)
        PersistenceController.shared.save() // Saves the patient.
        print("Add To Patient \(patient.name) \(patient.familyName) Journal: \(text)") // Prints a message each time the content is stored.
    }
}

struct PatientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PatientDetailView(patient: Patient.example(context: PersistenceController.preview.container.viewContext))
    }
}
