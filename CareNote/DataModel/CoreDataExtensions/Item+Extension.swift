//
//  Item+Extension.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-10.
//

import Foundation
import CoreData

extension Item {
    
    convenience init(name: String, context: NSManagedObjectContext) {
        self.init(context: context)
        // "self.timestamp = Date()" <- Isn't needed anymore, because "public override func awakeFromInsert()".
        self.name_ = name
    }
    
    
    
    // Technic sugar to gett nicer code:
    var timestamp: Date {
        get {
            timestamp_ ?? Date()
        }
        set {
            timestamp_ = newValue
        }
    }
    
    var name: String {
        get {
            name_ ?? ""
        }
        set {
            name_ = newValue
        }
    }
    
    
    
    /// Adds a value of value-type Date() to the property with the stringly typed name.
    public override func awakeFromInsert() {
        setPrimitiveValue(Date(), forKey: ItemProperties.timestamp)
        setPrimitiveValue("", forKey: ItemProperties.name)
    }
    
    static func delete(at offsets: IndexSet, for items: [Item]) {
        
        if let first = items.first, let viewContext = first.managedObjectContext {
            offsets.map { items[$0] }.forEach(viewContext.delete)
        }
    }
    
    static func fetch() -> NSFetchRequest<Item> {
        let request = NSFetchRequest<Item>(entityName: "Item")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.timestamp_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        return request
    }
    
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func example(context: NSManagedObjectContext) -> Item {
        Item(name: "example", context: context)
    }
    
    /// forKey Item-property names to reduce typing misstakes, when using it for stringly typed names och properties.
    struct ItemProperties {
        static let timestamp = "timestamp_"
        static let name = "name_"
    }
}
