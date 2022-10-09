//
//  Patient+Extension.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-14.
//

import Foundation
import CoreData

extension Patient {
    /// Is a faster way to initialise only properties that are needed. So you don't need to initialise all properties.
    convenience init(familyName: String, name: String, swedishSocialSecurityNumber: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.familyName_ = familyName
        self.name_ = name
        self.swedishSocialSecurityNumber_ = swedishSocialSecurityNumber
    } // <- It's a priority fast lane.
    
    
    
    
// MARK: - Properties for easier coding
    /*
     familyName
     id
     name
     swedishSocialSecurityNumber
     journalArray
     */
    
    
    public var familyName: String {
        get {
            familyName_ ?? "Unknown FamilyName"
        }
        set {
            familyName_ = newValue
        }
    }
    
    public var id: UUID {
        get {
            id_ ?? UUID()
        }
        set {
            id_ = newValue
        }
    }
    
    public var name: String {
        get {
            name_ ?? "Unknown Name"
        }
        set {
            name_ = newValue
        }
    }
    
    public var swedishSocialSecurityNumber: String {
        get {
            swedishSocialSecurityNumber_ ?? "19121212-1212"
        }
        set {
            swedishSocialSecurityNumber_ = newValue
        }
    }
// MARK: - Convert Properties with NSSet to an Swift-array
    public var journalArray: [Journal] { // will return an Array
        let set = journal as? Set<Journal> ?? [ ] // make a set called journal and store Journals in it otherwise make it empty.
        return set.sorted { // Sort the set to make i an array.
            $0.date < $1.date // sort the array by the first date against the second date.
        } // Returns the array asking for "[Journal]".
    }
    
    public var lawArray: [Law] {
        let set = law as? Set<Law> ?? [ ]
        return set.sorted {
            $0.date < $1.date
        }
    } // returns the array asking for "[Law]"
    
    public var readingArray: [Reading] {
        let set = reading as? Set<Reading> ?? [ ]
        return set.sorted {
            $0.date < $1.date
        }
    } // returns the array asking for "[Reading]"
    
    public var medicineArray: [Medicine] {
        let set = medicine as? Set<Medicine> ?? [ ]
        return set.sorted {
            $0.datePrescriptionIsStarting < $1.datePrescriptionIsStarting
        }
    } // returns the array asking for "[Medicine]"
    
    public var medicalTaskArray: [MedicalTask] {
        let set = medicalTask as? Set<MedicalTask> ?? [ ]
        return set.sorted {
            $0.date < $1.date
        }
    } // returns the array asking for "[MedicalTask]"
    
    
    /// forKey Patient-property names to reduce typing misstakes, when using i t for stringly typed names or properties.
    struct PatientProperties {
        static let familyName = "familyName_"
        static let id = "id_"
        static let name = "name_"
        static let swedishSocialSecurityNumber = "swedishSocialSecurityNumber_"
    }
    
    /// Adds a value of value-type Date() to the property with the stringly typed name.
    public override func awakeFromInsert() {
        setPrimitiveValue("", forKey: PatientProperties.familyName)
        setPrimitiveValue(UUID(), forKey: PatientProperties.id)
        setPrimitiveValue("", forKey: PatientProperties.name)
        setPrimitiveValue("", forKey: PatientProperties.swedishSocialSecurityNumber)
    }
    /// Deletes patienten from the list att the current position.
    static func delete(at offsets: IndexSet, for patients: [Patient]) {
        
        if let first = patients.first, let viewContext = first.managedObjectContext {
            offsets.map { patients[$0] }.forEach(viewContext.delete)
        }
        print("A patient has been removed from the list.")
    }
    /// A new (modified) fetch request initialized with the Entity represented by this subclass. This property's getter is only legal to call on subclasses of NSManagedObject that represent a single entity in the model.
    static func fetch() -> NSFetchRequest<Patient> {
        let request = NSFetchRequest<Patient>(entityName: "Patient")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Patient.name_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        return request
    }
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func example(context: NSManagedObjectContext) -> Patient {
        let patientForCanvas = Patient(familyName: "Swift", name: "Taylor", swedishSocialSecurityNumber: "89", context: context)
        for _ in 0...8 {
            patientForCanvas.addToJournal(Journal(date: Date.now, text: "ExamplePatientForCanvas", context: context))
            
            patientForCanvas.addToLaw(Law(date: Date.now, name: "ExampleLaw", paragraph: "ExParagraph", context: context))
            
            patientForCanvas.addToReading(Reading(amount: 60.0, date: Date.now, unit: "BPM", context: context))
            
            patientForCanvas.addToMedicine(
                Medicine(
                    datePrescriptionIsStarting: Date.now,
                    dateGiven: Date.now,
                    datePrescriptionIsEnding: Date.distantFuture,
                    dateSkipped: Date.now,
                    name: "0_Prescripted",
                    form: Care.Medicine.Form.tablet.rawValue,
                    frequency: Care.Medicine.Frequency.asNeeded.rawValue,
                    strength: 10.0,
                    unit: Care.Medicine.Unit.milliGram.rawValue,
                    amount: 1.0,
                    instruction: "ExampleInstruction",
                    isGiven: false,
                    isPrescripted: true,
                    isSkipped: false, context: context))
            
            patientForCanvas.addToMedicine(
                Medicine(
                    datePrescriptionIsStarting: Date.now,
                    dateGiven: Date.now,
                    datePrescriptionIsEnding: Date.distantFuture,
                    dateSkipped: Date.now,
                    name: "1_Given",
                    form: Care.Medicine.Form.tablet.rawValue,
                    frequency: Care.Medicine.Frequency.asNeeded.rawValue,
                    strength: 10.0,
                    unit: Care.Medicine.Unit.milliGram.rawValue,
                    amount: 1.0,
                    instruction: "ExampleInstruction",
                    isGiven: true,
                    isPrescripted: false,
                    isSkipped: false, context: context))
            
            patientForCanvas.addToMedicine(
                Medicine(
                    datePrescriptionIsStarting: Date.now,
                    dateGiven: Date.now,
                    datePrescriptionIsEnding: Date.distantFuture,
                    dateSkipped: Date.now,
                    name: "3_Skipped",
                    form: Care.Medicine.Form.tablet.rawValue,
                    frequency: Care.Medicine.Frequency.asNeeded.rawValue,
                    strength: 10.0,
                    unit: Care.Medicine.Unit.milliGram.rawValue,
                    amount: 1.0,
                    instruction: "ExampleInstruction",
                    isGiven: false,
                    isPrescripted: false,
                    isSkipped: true, context: context))
            
            patientForCanvas.addToMedicalTask(
                MedicalTask(
                    date: Date.now,
                    name: "ExampleTask", context: context))
        }
        
        
        
        return patientForCanvas
    }
}
