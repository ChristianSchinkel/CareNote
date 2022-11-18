//
//  PreScription+Extension.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-10-22.
//

import Foundation
import CoreData

extension PreScription {
    /// Is a faster way to initialise only properties that are needed. So you don't need to initialise all properties - only those you really want to be initialised by creating an instance of PreScription.
    convenience init(asNeeded: Bool,
                     asNeededMaxDoseAmount: Double,
                     asNeededMaxDosePerDayDate: Date,
                     asNeededMaxDoseStrengthValue: Double,
                     asNeededMaxDoseStrengthValueUnit: String,
                     frequency: String,
                     givenDate: Date,
                     instruction: String,
                     isGiven: Bool,
                     isPlanned: Bool,
                     isPrescripted: Bool,
                     isSkipped: Bool,
                     medicineActiveSubstance: String,
                     medicineDoseAmount: Double,
                     medicineAmountValue: Double,
                     medicineAmountValueUnit: String,
                     medicineForm: String,
                     medicineName: String,
                     medicineStrengthValue: Double,
                     medicineStrengthValueUnit: String,
                     modeOfAdministration: String,
                     reasonOfPrescribing: String,
                     shouldNotBeReplaced: Bool,
                     shouldNotBeReplacedReason: String,
                     skippedDate: Date,
                     treatmentDurationEndDate: Date,
                     treatmentDurationEndReason: String,
                     treatmentDurationStartDate: Date,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.asNeeded_ = asNeeded
        self.asNeededMaxDoseAmount_ = asNeededMaxDoseAmount
        self.asNeededMaxDosePerDayDate_ = asNeededMaxDosePerDayDate
        self.asNeededMaxDoseStrengthValue_ = asNeededMaxDoseStrengthValue
        self.asNeededMaxDoseStrengthValueUnit_ = asNeededMaxDoseStrengthValueUnit
        self.frequency_ = frequency
        self.givenDate_ = givenDate
        self.instruction_ = instruction
        self.isGiven_ = isGiven
        self.isPlanned_ = isPlanned
        self.isPrescripted_ = isPrescripted
        self.isSkipped_ = isSkipped
        self.medicineActiveSubstance_ = medicineActiveSubstance
        self.medicineDoseAmount_ = medicineDoseAmount
        self.medicineAmountValue_ = medicineAmountValue
        self.medicineAmountValueUnit_ = medicineAmountValueUnit
        self.medicineForm_ = medicineForm
        self.medicineName_ = medicineName
        self.medicineStrengthValue_ = medicineStrengthValue
        self.medicineStrengthValueUnit_ = medicineStrengthValueUnit
        self.modeOfAdministration_ = modeOfAdministration
        self.reasonOfPrescribing_ = reasonOfPrescribing
        self.shouldNotBeReplaced_ = shouldNotBeReplaced
        self.shouldNotBeReplacedReason_ = shouldNotBeReplacedReason
        self.skippedDate_ = skippedDate
        self.treatmentDurationEndDate_ = treatmentDurationEndDate
        self.treatmentDurationEndReason_ = treatmentDurationEndReason
        self.treatmentDurationStartDate_ = treatmentDurationStartDate
    } // <- It's a priority fast lane.
    
    
    
    
    // MARK: - Properties for easier coding
    /*
     asNeeded: Bool,
     asNeededMaxDoseAmount: Double,
     asNeededMaxDosePerDayDate: Date,
     asNeededMaxDoseStrengthValue: Double,
     asNeededMaxDoseStrengthValueUnit: String,
     datesForAdministration: Date,
     frequency: String,
     givenDate: Date,
     instruction: String,
     isGiven: Bool,
     isPrescripted: Bool,
     isSkipped: Bool,
     medicineActiveSubstance: String,
     medicineDoseAmount: Double,
     medicineForm: String,
     medicineName: String,
     medicineStrengthValue: Double,
     medicineStrengthValueUnit: String,
     modeOfAdministration: String,
     reasonOfPrescribing: String,
     shouldNotBeReplaced: Bool,
     shouldNotBeReplacedReason: String,
     skippedDate: Date,
     treatmentDurationEndDate: Date,
     treatmentDurationEndReason: String,
     treatmentDurationStartDate: Date,
     */
    // MARK: - Computed properties for PreScription
    /// As needed medicine?
    public var asNeeded: Bool {
        get {
            asNeeded_
        }
        set {
            asNeeded_ = newValue
        }
    }
    /// As needed maximum dose.
    public var asNeededMaxDoseAmount: Double {
        get {
            asNeededMaxDoseAmount_
        }
        set {
            asNeededMaxDoseAmount_ = newValue
        }
    }
    /// As needed maximum dose-date.
    public var asNeededMaxDosePerDayDate: Date {
        get {
            asNeededMaxDosePerDayDate_ ?? Date.now
        }
        set {
            asNeededMaxDosePerDayDate_ = newValue
        }
    }
    /// As needed maxdos value unit.
    public var asNeededMaxDoseStrengthValueUnit: String {
        get {
            asNeededMaxDoseStrengthValueUnit_ ?? ""
        }
        set {
            asNeededMaxDoseStrengthValueUnit_ = newValue
        }
    }
    /// As needed maximumdose strength value.
    public var asNeededMaxDoseStrengthValue: Double {
        get {
            asNeededMaxDoseStrengthValue_
        }
        set {
            asNeededMaxDoseStrengthValue_ = newValue
        }
    }
    /// Range of dates for administration.
    public var datesForAdministration: Date {
        get {
            datesForAdministration_ ?? Date.now
        }
        set {
            datesForAdministration_ = newValue
        }
    }
    /// The frequency when the medicine is given. *! Will be deprecated in a future version of CareNote!*
    public var frequency: String {
        get {
            frequency_ ?? ""
        }
        set {
            frequency_ = newValue
        }
    }
    /// The date medicine is given.
    public var givenDate: Date {
        get {
            givenDate_ ?? Date.now
        }
        set {
            givenDate_ = newValue
        }
    }
    /// Instruction for administration of medicine.
    public var instruction: String {
        get {
            instruction_ ?? ""
        }
        set {
            instruction_ = newValue
        }
    }
    /// Is the medicine given to the patient?
    public var isGiven: Bool {
        get {
            isGiven_
        }
        set {
            isGiven_ = newValue
        }
    }
    /// Is the medicine given to the patient?
    public var isPlanned: Bool {
        get {
            isPlanned_
        }
        set {
            isPlanned_ = newValue
        }
    }
    /// Is the medicine prescripted?
    public var isPrescripted: Bool {
        get {
            isPrescripted_
        }
        set {
            isPrescripted_ = newValue
        }
    }
    /// Is the medicine skipped?
    public var isSkipped: Bool {
        get {
            isSkipped_
        }
        set {
            isSkipped_ = newValue
        }
    }
    /// The active substance of medicine.
    public var medicineActiveSubstance: String {
        get {
            medicineActiveSubstance_ ?? ""
        }
        set {
            medicineActiveSubstance_ = newValue
        }
    }
    /// The amount of medicinen's dose.
    public var medicineDoseAmount: Double {
        get {
            medicineDoseAmount_
        }
        set {
            medicineDoseAmount_ = newValue
        }
    }
    /// The form of medicine.
    public var medicineForm: String {
        get {
            medicineForm_ ?? ""
        }
        set {
            medicineForm_ = newValue
        }
    }
    /// The Name of medicine.
    public var medicineName: String {
        get {
            medicineName_ ?? ""
        }
        set {
            medicineName_ = newValue
        }
    }
    public var medicineAmountValue: Double {
        get {
            medicineAmountValue_
        }
        set {
            medicineAmountValue_ = newValue
        }
    }
    public var medicineAmountValueUnit: String {
        get {
            medicineAmountValueUnit_ ?? ""
        }
        set {
            medicineAmountValueUnit_ = newValue
        }
    }
    /// The strength of the medicine.
    public var medicineStrengthValue: Double {
        get {
            medicineStrengthValue_
        }
        set {
            medicineStrengthValue_ = newValue
        }
    }
    /// The unit of the medicine's strength.
    public var medicineStrengthValueUnit: String {
        get {
            medicineStrengthValueUnit_ ?? ""
        }
        set {
            medicineStrengthValueUnit_ = newValue
        }
    }
    /// The mode of administration.
    public var modeOfAdministration: String {
        get {
            modeOfAdministration_ ?? ""
        }
        set {
            modeOfAdministration_ = newValue
        }
    }
    /// The reason of prescribing.
    public var reasonOfPrescribing: String {
        get {
            reasonOfPrescribing_ ?? ""
        }
        set {
            reasonOfPrescribing_ = newValue
        }
    }
    /// If the medicine shouldn't be replaced of an equal medicine.
    public var shouldNotBeReplaced: Bool {
        get {
            shouldNotBeReplaced_
        }
        set {
            shouldNotBeReplaced_ = newValue
        }
    }
    /// The reason why the medicine shouldn't be replaced of an equal medicine.
    public var shouldNotBeReplacedReason: String {
        get {
            shouldNotBeReplacedReason_ ?? ""
        }
        set {
            shouldNotBeReplacedReason_ = newValue
        }
    }
    /// The date medicine is skipped.
    public var skippedDate: Date {
        get {
            skippedDate_ ?? Date.now
        }
        set {
            skippedDate_ = newValue
        }
    }
    /// The date the treatment ends.
    public var treatmentDurationEndDate: Date {
        get {
            treatmentDurationEndDate_ ?? Date.now
        }
        set {
            treatmentDurationEndDate_ = newValue
        }
    }
    /// The reason why the treatment ends.
    public var treatmentDurationEndReason: String {
        get {
            treatmentDurationEndReason_ ?? ""
        }
        set {
            treatmentDurationEndReason_ = newValue
        }
    }
    /// The date the treatment starts.
    public var treatmentDurationStartDate: Date {
        get {
            treatmentDurationStartDate_ ?? Date.now
        }
        set {
            treatmentDurationStartDate_ = newValue
        }
    }
    
    // MARK: - Convert Properties with NSSet to an Swift-array
    /* This array is required for a one-to-many_AND_one-to-one-relationship NOT for one-to-one_AND_one-to-one-relationship. */
    public var medicineArray: [Medicine] { // will return an Array
        let set = medicine as? Set<Medicine> ?? [ ] // make a set called medicine and store medicines in it otherwise make it empty.
        return set.sorted { // Sort the set to make i an array.
            $0.name < $1.name // sort the array by the first name against the second name.
        } // Returns the array asking for "[Medicine]".
    }
    
    /// forKey PreScription-property names to reduce typing misstakes, when using i t for stringly typed names or properties.
    struct PreScriptionProperties {
        static let asNeeded = "asNeeded_"
        static let asNeededMaxDoseAmount = "asNeededMaxDoseAmount_"
        static let asNeededMaxDosePerDayDate = "asNeededMaxDosePerDayDate_"
        static let asNeededMaxDoseStrengthValue = "asNeededMaxDoseStrengthValue_"
        static let asNeededMaxDoseStrengthValueUnit = "asNeededMaxDoseStrengthValueUnit_"
        static let frequency = "frequency_"
        static let givenDate = "givenDate_"
        static let instruction = "instruction_"
        static let isGiven = "isGiven_"
        static let isPlanned = "isPlanned_"
        static let isPrescripted = "isPrescripted_"
        static let isSkipped = "isSkipped_"
        static let medicineActiveSubstance = "medicineActiveSubstance_"
        static let medicineDoseAmount = "medicineDoseAmount_"
        static let medicineAmountValue = "medicineAmountValue_"
        static let medicineAmountValueUnit = "medicineAmountValueUnit_"
        static let medicineForm = "medicineForm_"
        static let medicineName = "medicineName_"
        static let medicineStrengthValue = "medicineStrengthValue_"
        static let medicineStrengthValueUnit  = "medicineStrengthValueUnit_"
        static let modeOfAdministration = "modeOfAdministration_"
        static let reasonOfPrescribing = "reasonOfPrescribing_"
        static let shouldNotBeReplaced = "shouldNotBeReplaced_"
        static let shouldNotBeReplacedReason = "shouldNotBeReplacedReason_"
        static let skippedDate = "skippedDate_"
        static let treatmentDurationEndDate = "treatmentDurationEndDate_"
        static let treatmentDurationEndReason = "treatmentDurationEndReason_"
        static let treatmentDurationStartDate = "treatmentDurationStartDate_"
    }
    // MARK: - Functions in the extension
    /// Adds a value of value-type [Date(), String(), etc ] to the property with the stringly typed name.
    public override func awakeFromInsert() {
        setPrimitiveValue(Bool(), forKey: PreScriptionProperties.asNeeded)
        setPrimitiveValue(Double(), forKey: PreScriptionProperties.asNeededMaxDoseAmount)
        setPrimitiveValue(Date(), forKey: PreScriptionProperties.asNeededMaxDosePerDayDate)
        setPrimitiveValue(Double(), forKey: PreScriptionProperties.asNeededMaxDoseStrengthValue)
        setPrimitiveValue("", forKey: PreScriptionProperties.asNeededMaxDoseStrengthValueUnit)
        setPrimitiveValue("", forKey: PreScriptionProperties.frequency)
        setPrimitiveValue(Date(), forKey: PreScriptionProperties.givenDate)
        setPrimitiveValue("", forKey: PreScriptionProperties.instruction)
        setPrimitiveValue(Bool(), forKey: PreScriptionProperties.isGiven)
        setPrimitiveValue(Bool(), forKey: PreScriptionProperties.isPlanned)
        setPrimitiveValue(Bool(), forKey: PreScriptionProperties.isPrescripted)
        setPrimitiveValue(Bool(), forKey: PreScriptionProperties.isSkipped)
        setPrimitiveValue("", forKey: PreScriptionProperties.medicineActiveSubstance)
        setPrimitiveValue(Double(), forKey: PreScriptionProperties.medicineDoseAmount)
        setPrimitiveValue(Double(), forKey: PreScriptionProperties.medicineAmountValue)
        setPrimitiveValue("", forKey: PreScriptionProperties.medicineAmountValueUnit)
        setPrimitiveValue("", forKey: PreScriptionProperties.medicineForm)
        setPrimitiveValue("", forKey: PreScriptionProperties.medicineName)
        setPrimitiveValue(Double(), forKey: PreScriptionProperties.medicineStrengthValue)
        setPrimitiveValue("", forKey: PreScriptionProperties.medicineStrengthValueUnit)
        setPrimitiveValue("", forKey: PreScriptionProperties.modeOfAdministration)
        setPrimitiveValue("", forKey: PreScriptionProperties.reasonOfPrescribing)
        setPrimitiveValue(Bool(), forKey: PreScriptionProperties.shouldNotBeReplaced)
        setPrimitiveValue("", forKey: PreScriptionProperties.shouldNotBeReplacedReason)
        setPrimitiveValue(Date(), forKey: PreScriptionProperties.skippedDate)
        setPrimitiveValue(Date(), forKey: PreScriptionProperties.treatmentDurationEndDate)
        setPrimitiveValue("", forKey: PreScriptionProperties.treatmentDurationEndReason)
        setPrimitiveValue(Date(), forKey: PreScriptionProperties.treatmentDurationStartDate)
    }
    /// Deletes PreScription from the list att the current position.
    static func delete(at offsets: IndexSet, for preScription: [PreScription]) {
        
        if let first = preScription.first, let viewContext = first.managedObjectContext {
            offsets.map { preScription[$0] }.forEach(viewContext.delete)
        }
        print("A PreScription has been removed from the list.")
    }
    /// A new (modified) fetch request initialized with the Entity represented by this subclass. This property's getter is only legal to call on subclasses of NSManagedObject that represent a single entity in the model.
    static func fetch() -> NSFetchRequest<PreScription> {
        let request = NSFetchRequest<PreScription>(entityName: "PreScription")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \PreScription.treatmentDurationStartDate_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        return request
    }
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func example(context: NSManagedObjectContext) -> PreScription {
        
        let medForCanvasCandesartan = Medicine(name: "Candesartan", activeSubstance: "Candesartan", form: "Tablet", strengthValue: 4.0, strengthValueUnit: "mg", amountValue: 1.0, amountValueUnit: "pieces", isPlanned: true, hasPlannedDate: Date.now, isGivenOrTaken: false, hasGivenOrTakenDate: Date.now, isSkipped: false, hasSkippedDate: Date.now, context: context) // Medicine for CanvasExample.
        
        let medForCanvasSertraline = Medicine(name: "Sertraline", activeSubstance: "Sertraline", form: "Tablet", strengthValue: 100.0, strengthValueUnit: "mg", amountValue: 1.0, amountValueUnit: "pieces", isPlanned: true, hasPlannedDate: Date.now, isGivenOrTaken: false, hasGivenOrTakenDate: Date.now, isSkipped: false, hasSkippedDate: Date.now, context: context) // Medicine for CanvasExample.
        
        let medForCanvasMelatonin =  Medicine(name: "Melatonin", activeSubstance: "Melatonin", form: "Tablet", strengthValue: 2.0, strengthValueUnit: "mg", amountValue: 1.0, amountValueUnit: "pieces", isPlanned: true, hasPlannedDate: Date.now, isGivenOrTaken: false, hasGivenOrTakenDate: Date.now, isSkipped: false, hasSkippedDate: Date.now, context: context) // Medicine for CanvasExample.
        
        
        
        let preScriptionForCanvas = PreScription(
            asNeeded: false,
            asNeededMaxDoseAmount: 1.0,
            asNeededMaxDosePerDayDate: Date.now,
            asNeededMaxDoseStrengthValue: 2.0,
            asNeededMaxDoseStrengthValueUnit: Care.Medicine.Unit.milliGram.rawValue,
            frequency: "ExFrequency",
            givenDate: Date.now,
            instruction: "ExInstruct",
            isGiven: false,
            isPlanned: false,
            isPrescripted: false,
            isSkipped: false,
            medicineActiveSubstance: "Melatonin",
            medicineDoseAmount: 1.0,
            medicineAmountValue: 1.0,
            medicineAmountValueUnit: "st",
            medicineForm: Care.Medicine.Form.tablet.rawValue,
            medicineName: "Melatonin",
            medicineStrengthValue: 2.00,
            medicineStrengthValueUnit: Care.Medicine.Unit.milliGram.rawValue,
            modeOfAdministration: "Oral",
            reasonOfPrescribing: "Good Nigth sleep",
            shouldNotBeReplaced: false,
            shouldNotBeReplacedReason: "ExReason",
            skippedDate: Date.now,
            treatmentDurationEndDate: Date.TwoWeeksLater(from: Date.now),
            treatmentDurationEndReason: "ExReason",
            treatmentDurationStartDate: Date.now, context: context)
        
        
        preScriptionForCanvas.addToMedicine(medForCanvasCandesartan)
        preScriptionForCanvas.addToMedicine(medForCanvasSertraline)
        preScriptionForCanvas.addToMedicine(medForCanvasMelatonin)
        
        return preScriptionForCanvas
    }
}
