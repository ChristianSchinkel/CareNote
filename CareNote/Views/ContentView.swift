//
//  ContentView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-10.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        MainMenuTabView()
    }
// MARK: - Functions for this View:
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
