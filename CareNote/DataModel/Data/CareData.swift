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
    
    let howPatientComeIn = [
        "Police",
        "LOB",
        "LPT §47",
        "SS",
        "AMB",
        "PAM",
        "Remiss from"
    ]
    
    let suicidalRiskNiveau = [
        "low",
        "little",
        "medium",
        "high"
    ]
    
    let violenceRiskNiveau = [
        "low",
        "medium",
        "high"
    ]
    
    let typesOfObservation = [
        "normal",
        "X-OBS",
        "X-VAK",
        "X-VAK/X-OBS"
    ]
    
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
    
    enum medicineForm {
    case capsule
    }
}
