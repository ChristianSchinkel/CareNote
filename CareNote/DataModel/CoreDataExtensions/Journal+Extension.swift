//
//  Journal+Extension.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-15.
//

import Foundation
import CoreData

extension Journal {
    /// Is a faster way to initialise only properties that are needed. So you don't need to initialise all properties.
    convenience init(date: Date, text: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.date_ = date
        self.text_ = text
    } // <- It's a priority fast lane.
    
    
    
    
// MARK: - Properties for easier coding
    /*
     date
     text
     */
    
    
    public var date: Date {
        get {
            date_ ?? Date.now
        }
        set {
            date_ = newValue
        }
    }
    
    public var text: String {
        get {
            text_ ?? ""
        }
        set {
            text_ = newValue
        }
    }
    
    
    /// forKey Journal-property names to reduce typing misstakes, when using i t for stringly typed names or properties.
    struct JournalProperties {
        static let date = "date_"
        static let text = "text_"
    }
    
    /// Adds a value of value-type Date() to the property with the stringly typed name.
    public override func awakeFromInsert() {
        setPrimitiveValue(Date.now, forKey: JournalProperties.date)
        setPrimitiveValue("", forKey: JournalProperties.text)
    }
    /// Deletes journal from the list att the current position.
    static func delete(at offsets: IndexSet, for journal: [Journal]) {
        
        if let first = journal.first, let viewContext = first.managedObjectContext {
            offsets.map { journal[$0] }.forEach(viewContext.delete)
        }
        print("A journal-entry has been removed from the list.")
    }
    /// A new (modified) fetch request initialized with the Entity represented by this subclass. This property's getter is only legal to call on subclasses of NSManagedObject that represent a single entity in the model.
    static func fetch() -> NSFetchRequest<Journal> {
        let request = NSFetchRequest<Journal>(entityName: "Journal")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Journal.date_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        return request
    }
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func example(context: NSManagedObjectContext) -> Journal {
        Journal(date: Date.now, text: "Example for journal-entry", context: context)
    }
}
