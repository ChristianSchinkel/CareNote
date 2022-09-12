//
//  CareNoteApp.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-10.
//

import SwiftUI

@main
struct CareNoteApp: App {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase // checks for scenePhase.

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { phase in
            print(phase)
            // Saves the vieContext if the actual scenePhase is '.background'.
            if phase == .background {
                persistenceController.save()
            }
        }
    }
}
