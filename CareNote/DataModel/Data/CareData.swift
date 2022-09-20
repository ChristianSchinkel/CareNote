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
}
