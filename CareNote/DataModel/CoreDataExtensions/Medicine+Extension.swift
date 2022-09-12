//
//  Medicine+Extension.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-10.
//

import Foundation
import CoreData

extension Medicine {
    /// Is a faster way to initialise only properties that are needed. So you don't need to initialise all properties.
    convenience init(date: Date, name: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.date_ = date
        self.name_ = name
    } // <- It's a priority fast lane.
    
    
    
    
// MARK: - Properties for easier coding
    /*
     date
     name
     */
    
    
    public var date: Date {
        get {
            date_ ?? Date.now
        }
        set {
            date_ = newValue
        }
    }
    
    public var name: String {
        get {
            name_ ?? ""
        }
        set {
            name_ = newValue
        }
    }
    
    
    
    /// forKey Medicine-property names to reduce typing misstakes, when using i t for stringly typed names or properties.
    struct MedicineProperties {
        static let date = "date_"
        static let name = "name_"
    }
    
    /// Adds a value of value-type Date() to the property with the stringly typed name.
    public override func awakeFromInsert() {
        setPrimitiveValue(Date.now, forKey: MedicineProperties.date)
        setPrimitiveValue("", forKey: MedicineProperties.name)
    }
    /// Deletes law from the list att the current position.
    static func delete(at offsets: IndexSet, for medicine: [Medicine]) {
        
        if let first = medicine.first, let viewContext = first.managedObjectContext {
            offsets.map { medicine[$0] }.forEach(viewContext.delete)
        }
        print("A medicine-entry has been removed from the list.")
    }
    /// A new (modified) fetch request initialized with the Entity represented by this subclass. This property's getter is only legal to call on subclasses of NSManagedObject that represent a single entity in the model.
    static func fetch() -> NSFetchRequest<Medicine> {
        let request = NSFetchRequest<Medicine>(entityName: "Medicine")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Medicine.date_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        return request
    }
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func example(context: NSManagedObjectContext) -> Medicine {
        Medicine(date: Date.now, name: "ExampleMedicine", context: context)
    }

}
