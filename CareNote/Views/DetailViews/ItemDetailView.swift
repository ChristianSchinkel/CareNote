//
//  ItemDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-10.
//

import SwiftUI

struct ItemDetailView: View {
    @ObservedObject var item: Item
    
    var body: some View {
        VStack {
            TextField("name", text: $item.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: 300)
            
            Text(item.name)
            
            Text(item.timestamp.formatted(date: .long, time: .standard))
        }
        .padding()
    }
// MARK: - Functions for this View:
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(item: Item.example(context: PersistenceController.preview.container.viewContext))
    }
}
