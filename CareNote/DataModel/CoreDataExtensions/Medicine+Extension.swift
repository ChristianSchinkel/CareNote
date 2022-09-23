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
    convenience init(date: Date, name: String, form: String, frequency: String, strength: Double, unit: String, amount: Double, context: NSManagedObjectContext) {
        self.init(context: context)
        self.date_ = date
        self.name_ = name
        self.form_ = form
        self.frequency_ = frequency
        self.strength_ = strength
        self.unit_ = unit
        self.amount_ = amount
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
    /// The name of medicine.
    public var name: String {
        get {
            name_ ?? ""
        }
        set {
            name_ = newValue
        }
    }
    /// The form of medicine.
    public var form: String {
        get {
            form_ ?? ""
        }
        set {
            form_ = newValue
        }
    }
    /// The frequency for intake of medicine.
    public var frequency: String {
        get {
            frequency_ ?? ""
        }
        set {
            frequency_ = newValue
        }
    }
    
    /// The strength for medicine.
    public var strength: Double {
        get {
            strength_
        }
        set {
            strength_ = newValue
        }
    }
    /// The unit of medicine's strength.
    public var unit: String {
        get {
            unit_ ?? ""
        }
        set {
            unit_ = newValue
        }
    }
    /// The amount for medicine.
    public var amount: Double {
        get {
            amount_
        }
        set {
            amount_ = newValue
        }
    }
    
    /// forKey Medicine-property names to reduce typing misstakes, when using it for stringly typed names or properties.
    struct MedicineProperties {
        static let date = "date_"
        static let form = "form_"
        static let frequency = "frequency_"
        static let name = "name_"
        static let strength = "strength_"
        static let unit = "unit_"
        static let amount = "amount_"
    }
    
    /// Adds a value of value-type [Date(), String(), etc ] to the property with the stringly typed name.
    public override func awakeFromInsert() {
        setPrimitiveValue(Date.now, forKey: MedicineProperties.date)
        setPrimitiveValue("", forKey: MedicineProperties.form)
        setPrimitiveValue("", forKey: MedicineProperties.frequency)
        setPrimitiveValue("", forKey: MedicineProperties.name)
        setPrimitiveValue(Double(), forKey: MedicineProperties.strength)
        setPrimitiveValue("", forKey: MedicineProperties.unit)
        setPrimitiveValue(Double(), forKey: MedicineProperties.amount)
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
        Medicine(date: Date.now, name: "ExampleMedicine", form: "Tablet", frequency: "1", strength: 1.0, unit: "g", amount: 1.0, context: context)
    }

}
