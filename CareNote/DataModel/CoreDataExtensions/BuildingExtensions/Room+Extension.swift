//
//  Room+Extension.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-10-02.
//

import Foundation
import CoreData

extension Room {
    /// forKey Room-property names to reduce typing misstakes, when using i t for stringly typed names or properties.
    struct RoomProperties {
        static let name = "name_"
    }
    /// Adds a value of value-type Date() to the property with the stringly typed name.
    public override func awakeFromInsert() {
        setPrimitiveValue(UUID(), forKey: "id")
        setPrimitiveValue("", forKey: RoomProperties.name)
    }
    /// Deletes Room from the list att the current position.
    static func delete(at offsets: IndexSet, for room: [Room]) {
        
        if let first = room.first, let viewContext = first.managedObjectContext {
            offsets.map { room[$0] }.forEach(viewContext.delete)
        }
        print("A Room-entry has been removed from the list.")
    }
    /// A new (modified) fetch request initialized with the Entity represented by this subclass. This property's getter is only legal to call on subclasses of NSManagedObject that represent a single entity in the model.
    static func fetch() -> NSFetchRequest<Room> {
        let request = NSFetchRequest<Room>(entityName: "Room")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Room.name_, ascending: true)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        return request
    }
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func exampleRoom(context: NSManagedObjectContext) -> Room {
        Room(name: "ExampleRoom", context: context)
    }

}
