//
//  Hospital+Extension.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-10-02.
//

import Foundation
import CoreData

extension Hospital {
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
    
    
    
    /// forKey Hospital-property names to reduce typing misstakes, when using i t for stringly typed names or properties.
    struct HospitalProperties {
        static let name = "name_"
    }
    
    /// Adds a value of value-type Date() to the property with the stringly typed name.
    public override func awakeFromInsert() {
        setPrimitiveValue("", forKey: HospitalProperties.name)
    }
    /// Deletes hospital from the list att the current position.
    static func delete(at offsets: IndexSet, for hospital: [Hospital]) {
        
        if let first = hospital.first, let viewContext = first.managedObjectContext {
            offsets.map { hospital[$0] }.forEach(viewContext.delete)
        }
        print("A Hospital-entry has been removed from the list.")
    }
    /// A new (modified) fetch request initialized with the Entity represented by this subclass. This property's getter is only legal to call on subclasses of NSManagedObject that represent a single entity in the model.
    static func fetch() -> NSFetchRequest<Hospital> {
        let request = NSFetchRequest<Hospital>(entityName: "Hospital")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Hospital.name_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        return request
    }
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func example(context: NSManagedObjectContext) -> Hospital {
        Hospital(name: "ExampleHospital", context: context)
    }

}
