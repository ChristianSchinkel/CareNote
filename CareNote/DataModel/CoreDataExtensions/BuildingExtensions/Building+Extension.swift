//
//  Building+Extension.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-12-09.
//

import Foundation
import CoreData

extension Building {
    /// Is a faster way to initialise only properties that are needed. So you don't need to initialise all properties.
    convenience init(name: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name_ = name
    } // <- It's a priority fast lane.
// MARK: - Properties for easier coding
    /*
     name
     */
    
    public var name: String {
        get {
            name_ ?? ""
        }
        set {
            name_ = newValue
        }
    }
    /// forKey Building-property names to reduce typing misstakes, when using i t for stringly typed names or properties.
    struct BuildingProperties {
        static let name = "name_"
    }
    /// Adds a value of value-type Date() to the property with the stringly typed name.
    public override func awakeFromInsert() {
        setPrimitiveValue(UUID(), forKey: "id")
        setPrimitiveValue("", forKey: BuildingProperties.name)
    }
    /// Deletes Building from the list att the current position.
    static func delete(at offsets: IndexSet, for Building: [Building]) {
        
        if let first = Building.first, let viewContext = first.managedObjectContext {
            offsets.map { Building[$0] }.forEach(viewContext.delete)
        }
        print("A Building-entry has been removed from the list.")
    }
    /// A new (modified) fetch request initialized with the Entity represented by this subclass. This property's getter is only legal to call on subclasses of NSManagedObject that represent a single entity in the model.
    static func fetch() -> NSFetchRequest<Building> {
        let request = NSFetchRequest<Building>(entityName: "Building")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Building.name_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        return request
    }
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func example(context: NSManagedObjectContext) -> Building {
        Building(name: "ExampleBuilding", context: context)
    }
    
}
