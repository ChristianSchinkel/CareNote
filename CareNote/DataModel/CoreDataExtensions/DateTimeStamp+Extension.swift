//
//  DateTimeStamp+Extension.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-11-24.
//

import Foundation
import CoreData

extension DateTimeStamp {
    /// Is a faster way to initialise only properties that are needed. So you don't need to initialise all properties.
    convenience init(
        date: Date,
        isGivenOrTaken: Bool,
        isSkipped: Bool,
        
        context: NSManagedObjectContext) {
            self.init(context: context)
            
            self.date_ = date
            self.isGivenOrTaken_ = isGivenOrTaken
            self.isSkipped_ = isSkipped
            
            
    } // <- It's a priority fast lane.
    
    
    
    
// MARK: - Properties for easier coding
    /*
     date: Date,
     isGivenOrTaken: Bool,
     isSkipped: Bool,
     */
// MARK: DateTimeStamp-information here
    public var id: UUID {
        get {
            id_ ?? UUID()
        }
        set {
            id_ = newValue
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
    public var isGivenOrTaken: Bool {
        get {
            isGivenOrTaken_
        }
        set {
            isGivenOrTaken_ = newValue
        }
    }
    public var isSkipped: Bool {
        get {
            isSkipped_
        }
        set {
            isSkipped_ = newValue
        }
    }
    // --------

    /// forKey DateTimeStamp-property names to reduce typing misstakes, when using it for stringly typed names or properties.
    struct DateTimeStampProperties {
        static let id = "id_" // TODO: Maybe the 'id'-property has to change to a stored property and the computed property has to be removed.
        static let date = "date_"
        static let isGivenOrTaken = "isGivenOrTaken_"
        static let isSkipped = "isSkipped_"
        
        
    }
    
    /// Adds a value of value-type [Date(), String(), etc ] to the property with the stringly typed name.
    public override func awakeFromInsert() {
        setPrimitiveValue(UUID(), forKey: DateTimeStampProperties.id) // TODO: Maybe the 'id'-property has to change to a stored property and the computed property has to be removed.
        setPrimitiveValue(Bool(), forKey: DateTimeStampProperties.isGivenOrTaken)
        setPrimitiveValue(Bool(), forKey: DateTimeStampProperties.isSkipped)
    }
    /// Deletes law from the list att the current position.
    static func delete(at offsets: IndexSet, for dateTimeStamp: [DateTimeStamp]) {
        
        if let first = dateTimeStamp.first, let viewContext = first.managedObjectContext {
            offsets.map { dateTimeStamp[$0] }.forEach(viewContext.delete)
        }
        print("A dateTimeStamp-entry has been removed from the list.")
    }
    /// A new (modified) fetch request initialized with the Entity represented by this subclass. This property's getter is only legal to call on subclasses of NSManagedObject that represent a single entity in the model.
    static func fetch() -> NSFetchRequest<DateTimeStamp> {
        let request = NSFetchRequest<DateTimeStamp>(entityName: "DateTimeStamp")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \DateTimeStamp.date_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        return request
    }
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func example(context: NSManagedObjectContext) -> DateTimeStamp {
        DateTimeStamp(date: Date.now, isGivenOrTaken: false, isSkipped: false, context: context)
    }
}
