//
//  MainMenuTabView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-14.
//

import SwiftUI

struct MainMenuTabView: View {
    @State private var selectedTab = 1 // shows the 'value'-tag (it also kan be string or other types that are declared somehow) of the selected tab.
    
    var body: some View {
        TabView(selection: $selectedTab) { // TabViews selection '$'-binding to @State private var selectedTab - here primary value of 1.
            PatientListView()
                .tabItem {
                    Label("Patients", systemImage: "list.bullet") }.tag(1)
            Text("Tab Content 2")
                .tabItem {
                    Label("Overview", systemImage: "checklist") }.tag(2)
            Text("Tab Content 3")
                .tabItem {
                    Label("Browse", systemImage: "square.grid.2x2.fill") }.tag(3)
        }
    }
}

struct MainMenuTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuTabView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
