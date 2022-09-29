//
//  CareData.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-18.
//

import Foundation

struct Care {
    let laws = [
        "HSL",
        "LPT",
        "LVM",
        "LVU",
        "LRV"
    ]
    
    enum LawsEnumserDeklarerad: String {
        case HSL, LPT, LVM, LVU, LRV
    }
    
    let howPatientComeIn = [
        "Police",
        "LOB",
        "LPT §47",
        "SS",
        "AMB",
        "PAM",
        "Remiss from"
    ]
    
    enum HowPatientComeInEnumserDeklarerad: String {
        case police = "Police"
        case lob = "LOB"
        case lptParagraph47 = "LPT §47"
        case ss = "SS"
        case amb = "AMB"
        case pam = "PAM"
        case remissFrom = "Remiss from"
    }
    
    let suicidalRiskNiveau = [
        "low",
        "little",
        "medium",
        "high"
    ]
    
    enum SuicidalRiskNiveauEnumserDeklarerad: String {
        case low, little, medium, high
    }
    
    let violenceRiskNiveau = [
        "low",
        "medium",
        "high"
    ]
    
    enum ViolenceRiskNiveauEnumserDeklarerad: String {
        case low, medium, high
    }
    
    let typesOfObservation = [
        "normal",
        "X-OBS",
        "X-VAK",
        "X-VAK/X-OBS"
    ]
    
    enum TypesOfObservationEnumserDeklarerad: String {
        case normal = "normal"
        case xobs = "X-OBS"
        case xvak = "X-VAK"
        case xvakXobs = "X-VAK/X-OBS"
    }
    
    struct Medicine {
        let form = [
        "Capsule",
        "Tablet",
        "Liquid",
        "Topical",
        "Cream",
        "Device",
        "Drops",
        "Foam",
        "Gel",
        "Inhaler",
        "Injection",
        "Lotion",
        "Ointment",
        "Patch",
        "Powder",
        "Spray",
        "Suppository"
        ]
        
        let unit = [
        "mg",
        "µg",
        "g",
        "ml",
        "%"
        ]
        
        let frequency = [
        "At Regular Intervals",
        "On Specific Days of the Week",
        "As Needed"
        ]
        
        let chosenInterval = [
        "Day",
        "Other Day",
        "3 Days",
        "4 Days",
        "99 Days"
        ]
        
        let chosenDay = [
        "M",
        "T",
        "W",
        "T",
        "F",
        "S",
        "S"
        ]
        
        let startDate = Date.now
    }
    
    enum MedicineForm: String {
        case capsule, tablet, liquid, topical, cream, device, drops, foam, gel, inhaler, injection, lotion, ointment, patch, powder, spray, suppository
    }
    
    enum MedicineUnit: String {
        case milliGram = "mg"
        case mikroGram = "µg"
        case gram = "g"
        case milliLiter = "ml"
        case procent = "%"
    }
    
    enum MedicineFrequency: String {
        case atRegularIntervals = "At Regular Intervals"
        case onSpecificDaysOfTheWeek = "On Specific Days of the Week"
        case asNeeded = "As Needed"
    }
    
    enum MedicineChosenInterval: String {
        case day = "Day"
        case otherDay = "Other Day"
        case threeDays = "3 Days"
        case fourDays = "4 Days"
        case ninetyNineDays = "99 Days"
    }
    
    enum MedicineChosenDay: String {
        case Monday = "Mon"
        case Tuesday = "Tue"
        case Wednesday = "Wed"
        case Thursday = "Thu"
        case Friday = "Fri"
        case Saturday = "Sat"
        case Sunday = "Sun"
    }
    
}
