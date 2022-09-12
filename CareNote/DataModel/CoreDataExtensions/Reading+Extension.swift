//
//  Reading+Extension.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-09.
//

import Foundation
import CoreData

extension Reading {
    /// Is a faster way to initialise only properties that are needed. So you don't need to initialise all properties.
    convenience init(amount: Double, date: Date, unit: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.amount_ = amount
        self.date_ = date
        self.unit_ = unit
    } // <- It's a priority fast lane.
    
    
    
    
// MARK: - Properties for easier coding
    /*
     amount
     date
     unit
     */
    
    public var amount: Double {
        get {
            amount_ 
        }
        set {
            amount_ = newValue
        }
    }
    
    public var date: Date {
        get {
            date_ ?? Date.now
        }
        set {
            date_ = newValue
        }
    }
    
    public var unit: String {
        get {
            unit_ ?? ""
        }
        set {
            unit_ = newValue
        }
    }

    
    
    /// forKey Readings-property names to reduce typing misstakes, when using i t for stringly typed names or properties.
    struct ReadingProperties {
        static let amount = "amount_"
        static let date = "date_"
        static let unit = "unit_"
    }
    
    /// Adds a value of value-type Date() to the property with the stringly typed name.
    public override func awakeFromInsert() {
        setPrimitiveValue(0.0, forKey: ReadingProperties.amount)
        setPrimitiveValue(Date.now, forKey: ReadingProperties.date)
        setPrimitiveValue("", forKey: ReadingProperties.unit)
    }
    /// Deletes reading from the list att the current position.
    static func delete(at offsets: IndexSet, for reading: [Reading]) {
        
        if let first = reading.first, let viewContext = first.managedObjectContext {
            offsets.map { reading[$0] }.forEach(viewContext.delete)
        }
        print("A reading-entry has been removed from the list.")
    }
    /// A new (modified) fetch request initialized with the Entity represented by this subclass. This property's getter is only legal to call on subclasses of NSManagedObject that represent a single entity in the model.
    static func fetch() -> NSFetchRequest<Law> {
        let request = NSFetchRequest<Law>(entityName: "Reading")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Reading.date_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        return request
    }
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func example(context: NSManagedObjectContext) -> Reading {
        Reading(amount: 0.0, date: Date.now, unit: "IU", context: context)
    }

}
