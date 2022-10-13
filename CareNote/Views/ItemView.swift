//
//  ItemView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-13.
//

import SwiftUI
import CoreData

struct ItemView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: Item.fetch(), animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        ItemDetailView(item: item)
                    } label: {
                        Text(item.timestamp, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item") // This view appears on iPads in the middle of the screen, if no item was selected.
        }
    }
// MARK: - Functions for this View:
    private func addItem() {
        withAnimation {
            _ = Item(name: "name", context: viewContext) // Creates the item the item (Item+helper; extension!).
            PersistenceController.shared.save() // Saves the viewContext.
        }
    }

    private func deleteItem(offsets: IndexSet) {
        withAnimation {
            Item.delete(at: offsets, for: Array(items)) // Calls delete-function in Item+helper.
            PersistenceController.shared.save() // Saves the viewContext.
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
