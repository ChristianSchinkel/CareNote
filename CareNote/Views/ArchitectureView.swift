//
//  ArchitectureView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-12-09.
//

import SwiftUI

struct ArchitectureView: View {
    @Environment(\.managedObjectContext) private var viewContext
    // MARK: FetchRequests
    @FetchRequest(fetchRequest: Hospital.fetch(), animation: .default)
    private var hospitals: FetchedResults<Hospital>
    @FetchRequest(fetchRequest: Ward.fetch(), animation: .default)
    private var wards: FetchedResults<Ward>
    @FetchRequest(fetchRequest: Room.fetch(), animation: .default)
    private var rooms: FetchedResults<Room>
    // MARK: View Properties
    @State private var hospitalName = "S:t Görans, BCS"
    @State private var wardName = "Avdelning 8"
    @State private var amountOfRooms = 20
    
    var body: some View {
        VStack {
            Form {
                TextField("Hospital", text: $hospitalName)
                TextField("Ward", text: $wardName)
                Stepper(value: $amountOfRooms, in: 1 ... 25) {
                    Text("Rooms: \(amountOfRooms)")
                }
                .onChange(of: amountOfRooms) { newValue in
                    buildHospital()
                }
                
                List {
                    ForEach(rooms) {
                        Text($0.name)
                    }
                }
            }
            Button("Build") {
                buildHospital()
            }
            .buttonStyle(.borderedProminent)
        }
    }
    // MARK: - Functions for this View:
    private func buildHospital() {
        rooms.isEmpty ?  print("There are no rooms.") : rooms.forEach(viewContext.delete)
        PersistenceController.shared.save()
        
        var count = 0
        let newHospital = Hospital(name: hospitalName, context: viewContext)
        let newWard = Ward(name: wardName, context: viewContext)
        
        guard rooms.isEmpty else {
            return print("There are \(amountOfRooms) rooms.")
        }
        while count < amountOfRooms {
            count += 1
            let newRoom = Room(name: "Room \(count)", context: viewContext)
            newWard.addToRoom(newRoom)
            print("\(newRoom.name) was built.")
        }
        
        newHospital.addToWard(newWard)
        PersistenceController.shared.save()
        print("*** Call to private func buildHospital ***\n \(hospitalName)\n \(wardName)\n with \(amountOfRooms) rooms was built.")
    }
}

struct ArkitectureView_Previews: PreviewProvider {
    static var previews: some View {
        ArchitectureView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
