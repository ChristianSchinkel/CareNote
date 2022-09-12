//
//  Law+Extension.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-09.
//

import Foundation
import CoreData

extension Law {
    /// Is a faster way to initialise only properties that are needed. So you don't need to initialise all properties.
    convenience init(date: Date, name: String, paragraph: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.date_ = date
        self.name_ = name
        self.paragraph_ = paragraph
    } // <- It's a priority fast lane.
    
    
    
    
// MARK: - Properties for easier coding
    /*
     date
     name
     paragraph
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
    
    public var paragraph: String {
        get {
            paragraph_ ?? ""
        }
        set {
            paragraph_ = newValue
        }
    }
    
    
    /// forKey Law-property names to reduce typing misstakes, when using i t for stringly typed names or properties.
    struct LawProperties {
        static let date = "date_"
        static let name = "name_"
        static let paragraph = "paragraph_"
    }
    
    /// Adds a value of value-type Date() to the property with the stringly typed name.
    public override func awakeFromInsert() {
        setPrimitiveValue(Date.now, forKey: LawProperties.date)
        setPrimitiveValue("", forKey: LawProperties.name)
        setPrimitiveValue("", forKey: LawProperties.paragraph)
    }
    /// Deletes law from the list att the current position.
    static func delete(at offsets: IndexSet, for law: [Law]) {
        
        if let first = law.first, let viewContext = first.managedObjectContext {
            offsets.map { law[$0] }.forEach(viewContext.delete)
        }
        print("A law-entry has been removed from the list.")
    }
    /// A new (modified) fetch request initialized with the Entity represented by this subclass. This property's getter is only legal to call on subclasses of NSManagedObject that represent a single entity in the model.
    static func fetch() -> NSFetchRequest<Law> {
        let request = NSFetchRequest<Law>(entityName: "Law")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Law.date_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        return request
    }
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func example(context: NSManagedObjectContext) -> Law {
        Law(date: Date.now, name: "ExampleLaw", paragraph: "§ 19a", context: context)
    }

}
