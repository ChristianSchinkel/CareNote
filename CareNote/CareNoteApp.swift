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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
