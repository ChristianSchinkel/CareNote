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
    convenience init(
        datePrescriptionIsStarting: Date,
        dateGiven: Date,
        datePrescriptionIsEnding: Date,
        dateSkipped: Date,
        
        name: String,
        form: String,
        frequency: String,
        strength: Double,
        unit: String,
        amount: Double,
        
        instruction: String,
        
        isGiven: Bool,
        isPrescripted: Bool,
        isSkipped: Bool,
        
        context: NSManagedObjectContext) {
            self.init(context: context)
            
            self.datePrescriptionIsStarting_ = datePrescriptionIsStarting
            self.dateGiven_ = dateGiven
            self.datePrescriptionIsEnding_ = datePrescriptionIsEnding
            self.dateSkipped_ = dateSkipped
            
            self.name_ = name
            self.form_ = form
            self.frequency_ = frequency
            self.strength_ = strength
            self.unit_ = unit
            self.amount_ = amount
            
            self.instruction_ = instruction
            
            self.isGiven_ = isGiven
            self.isPrescripted_ = isPrescripted
            self.isSkipped_ = isSkipped
    } // <- It's a priority fast lane.
    
    
    
    
// MARK: - Properties for easier coding
    /*
     date
     name
     */
// MARK: Dates here
    /// Medicine's prescription-date.
    public var datePrescriptionIsStarting: Date {
        get {
            datePrescriptionIsStarting_ ?? Date.now
        }
        set {
            datePrescriptionIsStarting_ = newValue
        }
    }
    /// Medicine's given-date
    public var dateGiven: Date {
        get {
            dateGiven_ ?? Date.now
        }
        set {
            dateGiven_ = newValue
        }
    }
    /// Medicine's prescription's ending-date.
    public var datePrescriptionIsEnding: Date {
        get {
            datePrescriptionIsEnding_ ?? Date.distantFuture
        }
        set {
            datePrescriptionIsEnding_ = newValue
        }
    }
    /// Medicine's dateSkipped_.
    public var dateSkipped: Date {
        get {
            dateSkipped_ ?? Date.now
        }
        set {
            dateSkipped_ = newValue
        }
    }
// MARK: Medicine-information here
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
    /// The unit of medicine's unit.
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
    
    /// Instructions for intake of medicine.
    public var instruction: String {
        get {
            instruction_ ?? ""
        }
        set {
            instruction_ = newValue
        }
    }
// MARK: Bolean here
    /// Is medicine given?
    public var isGiven: Bool {
        get {
            isGiven_
        }
        set {
            isGiven_ = newValue
        }
    }
    /// Is medicine given?
    public var isPrescripted: Bool {
        get {
            isPrescripted_
        }
        set {
            isPrescripted_ = newValue
        }
    }
    /// Is medicine given?
    public var isSkipped: Bool {
        get {
            isSkipped_
        }
        set {
            isSkipped_ = newValue
        }
    }
    /// forKey Medicine-property names to reduce typing misstakes, when using it for stringly typed names or properties.
    struct MedicineProperties {
        static let datePrescriptionIsStarting = "datePrescriptionIsStarting_"
        static let dateGiven = "dateGiven_"
        static let datePrescriptionIsEnding = "datePrescriptionIsEnding_"
        static let dateSkipped = "dateSkipped_"
        
        static let form = "form_"
        static let frequency = "frequency_"
        static let name = "name_"
        static let strength = "strength_"
        static let unit = "unit_"
        static let amount = "amount_"
        
        static let instruction = "instruction_"
        
        static let isGiven = "isGiven_"
        static let isPrescripted = "isPrescripted_"
        static let isSkipped = "isSkipped_"
    }
    
    /// Adds a value of value-type [Date(), String(), etc ] to the property with the stringly typed name.
    public override func awakeFromInsert() {
        setPrimitiveValue(Date.now, forKey: MedicineProperties.datePrescriptionIsStarting)
        setPrimitiveValue(Date.now, forKey: MedicineProperties.dateGiven)
        setPrimitiveValue(Date.distantFuture, forKey: MedicineProperties.datePrescriptionIsEnding)
        setPrimitiveValue(Date.now, forKey: MedicineProperties.dateSkipped)
        
        setPrimitiveValue("", forKey: MedicineProperties.form)
        setPrimitiveValue("", forKey: MedicineProperties.frequency)
        setPrimitiveValue("", forKey: MedicineProperties.name)
        setPrimitiveValue(Double(), forKey: MedicineProperties.strength)
        setPrimitiveValue("", forKey: MedicineProperties.unit)
        setPrimitiveValue(Double(), forKey: MedicineProperties.amount)
        
        setPrimitiveValue("", forKey: MedicineProperties.instruction)
        
        setPrimitiveValue(Bool(), forKey: MedicineProperties.isGiven)
        setPrimitiveValue(Bool(), forKey: MedicineProperties.isPrescripted)
        setPrimitiveValue(Bool(), forKey: MedicineProperties.isSkipped)
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
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Medicine.datePrescriptionIsStarting_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        return request
    }
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func example(context: NSManagedObjectContext) -> Medicine {
        Medicine(datePrescriptionIsStarting: Date.now, dateGiven: Date.now, datePrescriptionIsEnding: Date.distantFuture, dateSkipped: Date.now, name: "ExampleMedicine", form: "Tablet", frequency: "1", strength: 1.0, unit: "g", amount: 1.0, instruction: "ExampleInstruction", isGiven: false, isPrescripted: false, isSkipped: false, context: context)
    }

}
