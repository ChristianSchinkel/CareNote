//
//  SettingsView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-10-08.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    Text("General Settings")
                } label: {
                    Text("General settings")
                }
                
                NavigationLink {
                    ArchitectureView()
                } label: {
                    Text("Buildings & Rooms")
                }
                
                NavigationLink {
                    Text("Favorite PreScriptions")
                } label: {
                    Text("Favorite PreScriptions")
                }
            }
            .navigationTitle("Settings")
        }
    }
    // MARK: - Functions for this View:
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
