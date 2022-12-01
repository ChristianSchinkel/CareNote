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
        name: String,
        activeSubstance: String,
        form: String,
        strengthValue: Double,
        strengthValueUnit: String,
        amountValue: Double,
        amountValueUnit: String,
        isPlanned: Bool,
        hasPlannedDate: Date,
        isGivenOrTaken: Bool,
        hasGivenOrTakenDate: Date,
        isSkipped: Bool,
        hasSkippedDate: Date,
        
        context: NSManagedObjectContext) {
            self.init(context: context)
            
            self.name_ = name
            self.activeSubstance_ = activeSubstance
            self.form_ = form
            self.strengthValue_ = strengthValue
            self.strengthValueUnit_ = strengthValueUnit
            self.amountValue_ = amountValue
            self.amountValueUnit_ = amountValueUnit
            self.isPlanned_ = isPlanned
            self.hasPlannedDate_ = hasPlannedDate
            self.isGivenOrTaken_ = isGivenOrTaken
            self.hasGivenOrTakenDate_ = hasGivenOrTakenDate
            self.isSkipped_ = isSkipped
            self.hasSkippedDate_ = hasSkippedDate
            
            
        } // <- It's a priority fast lane.
    
    
    
    
    // MARK: - Properties for easier coding
    /*
     name: String,
     activeSubstance: String,
     form: String,
     strengthValue: Double,
     strengthValueUnit: String,
     amountValue: Double,
     amountValueUnit: String,
     isPlanned: Bool,
     hasPlannedDate: Date,
     isGivenOrTaken: Bool,
     hasGivenOrTakenDate: Date,
     isSkipped: Bool,
     hasSkippedDate: Date,
     */
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
    /// The name of active substance.
    public var activeSubstance: String {
        get {
            activeSubstance_ ?? ""
        }
        set {
            activeSubstance_ = newValue
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
    // --------
    public var strengthValue: Double {
        get {
            strengthValue_
        }
        set {
            strengthValue_ = newValue
        }
    }
    public var strengthValueUnit: String {
        get {
            strengthValueUnit_ ?? ""
        }
        set {
            strengthValueUnit_ = newValue
        }
    }
    public var amountValue: Double {
        get {
            amountValue_
        }
        set {
            amountValue_ = newValue
        }
    }
    public var amountValueUnit: String {
        get {
            amountValueUnit_ ?? ""
        }
        set {
            amountValueUnit_ = newValue
        }
    }
    public var isPlanned: Bool {
        get {
            isPlanned_
        }
        set {
            isPlanned_ = newValue
        }
    }
    public var hasPlannedDate: Date {
        get {
            hasPlannedDate_ ?? Date.now
        }
        set {
            hasPlannedDate_ = newValue
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
    public var hasGivenOrTakenDate: Date {
        get {
            hasGivenOrTakenDate_ ?? Date.now
        }
        set {
            hasGivenOrTakenDate_ = newValue
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
    public var hasSkippedDate: Date {
        get {
            hasSkippedDate_ ?? Date.now
        }
        set {
            hasSkippedDate_ = newValue
        }
    }
    // --------
    
    /// forKey Medicine-property names to reduce typing misstakes, when using it for stringly typed names or properties.
    struct MedicineProperties {
        static let name = "name_"
        static let activeSubstance = "activeSubstance_"
        static let form = "form_"
        static let strengthValue = "strengthValue_"
        static let strengthValueUnit = "strengthValueUnit_"
        static let amountValue = "amountValue_"
        static let amountValueUnit = "amountValueUnit_"
        static let isPlanned = "isPlanned_"
        static let hasPlannedDate = "hasPlannedDate_"
        static let isGivenOrTaken = "isGivenOrTaken_"
        static let hasGivenOrTakenDate = "hasGivenOrTakenDate_"
        static let isSkipped = "isSkipped_"
        static let hasSkippedDate = "hasSkippedDate_"
        
        
    }
    // MARK: - Convert Properties with NSSet to an Swift-array
    public var DateTimeStampArray: [DateTimeStamp] { // will return an Array
        let set = dateTimeStamp as? Set<DateTimeStamp> ?? [ ] // make a set called journal and store Journals in it otherwise make it empty.
        return set.sorted { // Sort the set to make i an array.
            $0.date < $1.date // sort the array by the first date against the second date.
        } // Returns the array asking for "[DateTimeStamp]".
    }
    /// Adds a value of value-type [Date(), String(), etc ] to the property with the stringly typed name.
    public override func awakeFromInsert() {
        setPrimitiveValue(UUID(), forKey: "id")
        setPrimitiveValue("", forKey: MedicineProperties.name)
        setPrimitiveValue("", forKey: MedicineProperties.activeSubstance)
        setPrimitiveValue("", forKey: MedicineProperties.form)
        setPrimitiveValue(Double(), forKey: MedicineProperties.strengthValue)
        setPrimitiveValue("", forKey: MedicineProperties.strengthValueUnit)
        setPrimitiveValue(Double(), forKey: MedicineProperties.amountValue)
        setPrimitiveValue("", forKey: MedicineProperties.amountValueUnit)
        setPrimitiveValue(Bool(), forKey: MedicineProperties.isPlanned)
        //        setPrimitiveValue(Date(), forKey: MedicineProperties.hasPlannedDate)
        setPrimitiveValue(Bool(), forKey: MedicineProperties.isGivenOrTaken)
        //        setPrimitiveValue(Date(), forKey: MedicineProperties.hasGivenOrTakenDate)
        setPrimitiveValue(Bool(), forKey: MedicineProperties.isSkipped)
        //        setPrimitiveValue(Date(), forKey: MedicineProperties.hasSkippedDate)
    }
    /// Deletes medicine from the list att the current position.
    static func delete(at offsets: IndexSet, for medicine: [Medicine]) {
        
        if let first = medicine.first, let viewContext = first.managedObjectContext {
            offsets.map { medicine[$0] }.forEach(viewContext.delete)
        }
        print("A medicine-entry has been removed from the list.")
    }
    /// A new (modified) fetch request initialized with the Entity represented by this subclass. This property's getter is only legal to call on subclasses of NSManagedObject that represent a single entity in the model.
    static func fetch() -> NSFetchRequest<Medicine> {
        let request = NSFetchRequest<Medicine>(entityName: "Medicine")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Medicine.name_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        return request
    }
    // TODO: function that removes all medicine tiles with date in future and has name -> use fetchrequest and a predicate that matches these conditions.
    static func fetchToDeleteInNearFuture(at offsets: IndexSet, for preScription: [PreScription], context: NSManagedObjectContext) {
        
        if let first = preScription.first {
            print("--> THIS IS THE FIRST OBJECT \(first.medicineName) <--")
            let requestToDelete = NSFetchRequest<Medicine>(entityName: "Medicine")
            requestToDelete.sortDescriptors = [NSSortDescriptor(keyPath: \Medicine.name_, ascending: false)]
            // Create the component predicates
            let datePredicate = NSPredicate(format: "\(MedicineProperties.hasPlannedDate) >= %@", Date.now as CVarArg)
            let namePredicate = NSPredicate(format: "\(MedicineProperties.name) == %@", first.medicineName)
            let activeSubstancePredicate = NSPredicate(format: "\(MedicineProperties.activeSubstance) == %@", first.medicineActiveSubstance)
            let formPredicate = NSPredicate(format: "\(MedicineProperties.form) == %@", first.medicineForm)
//            let strengthValuePredicate = NSPredicate(format: "\(MedicineProperties.strengthValue) == %@", first.medicineStrengthValue)
//            let strengthValueUnitPredicate = NSPredicate(format: "\(MedicineProperties.strengthValueUnit) == %@", first.medicineStrengthValueUnit)
//            let amountValuePredicate = NSPredicate(format: "\(MedicineProperties.amountValue) == %@", first.medicineAmountValue)
//            let amountValueUnitPredicate = NSPredicate(format: "\(MedicineProperties.amountValueUnit) == %@", first.medicineAmountValueUnit)
            
            requestToDelete.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [datePredicate, namePredicate, activeSubstancePredicate, formPredicate])
            
            /* Create an "and" compound predicate, meaning the query requires all the predicates to be satisfied. In other words, for an object to be returned by an "and" compound predicate, all the component predicates must be true for the object.*/
            
            requestToDelete.includesPropertyValues = false /* Setting includesPropertyValues to false means the fetch request will only get the managed object ID for each object */
            let medicinesToDelete = try! context.fetch(requestToDelete)
            print("--> THIS ARE THE OBJECTS TO DELETE \(medicinesToDelete) <--")
            medicinesToDelete.forEach(context.delete)
            
        }
    }
    
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func example(context: NSManagedObjectContext) -> Medicine {
        Medicine(name: "Stesolid", activeSubstance: "Diazepam", form: "Tablet", strengthValue: 10.0, strengthValueUnit: "mg", amountValue: 1.0, amountValueUnit: "pieces", isPlanned: true, hasPlannedDate: Date.now, isGivenOrTaken: false, hasGivenOrTakenDate: Date.now, isSkipped: false, hasSkippedDate: Date.now, context: context)
    }
    /// Makes a new Medicine-object of the given parameters
    /// - Parameters:
    ///   - name: Medicine's Name
    ///   - activeSubstance: Medicine's ActiveSubstance
    ///   - form: Medicine's Form
    ///   - strengthValue: Medicine's StrengthValue
    ///   - strengthValueUnit: Medicine's strengthValueUnit
    ///   - amountValue: Medicine's amountValue
    ///   - amountValueUnit: Medicine's amountValueUnit
    ///   - date: date the medicine gets placed in.
    ///   - context: NSManagedObjectContext
    /// - Returns: newMedicine
    static func makeObject(name: String, activeSubstance: String, form: String, strengthValue: Double, strengthValueUnit: String, amountValue: Double, amountValueUnit: String, with date: Date, context: NSManagedObjectContext) -> Medicine {
        let newMedicine = Medicine(context: context)
        
        newMedicine.name = name
        newMedicine.activeSubstance = activeSubstance
        newMedicine.form = form
        newMedicine.strengthValue = strengthValue
        newMedicine.strengthValueUnit = strengthValueUnit
        newMedicine.amountValue = amountValue
        newMedicine.amountValueUnit = amountValueUnit
        newMedicine.isPlanned = true
        newMedicine.hasPlannedDate = date
        newMedicine.isGivenOrTaken = false
        newMedicine.isGivenOrTaken = false
        newMedicine.isSkipped = false
        
        print(newMedicine)
        
        return newMedicine
    }
}
