//
//  CareData.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-18.
//

import Foundation

struct Care {
    enum Laws: String, CaseIterable {
        case HSL, LPT, LVM, LVU, LRV
    }
    
    enum HowPatientComeIn: String, CaseIterable {
        case police = "Police"
        case lob = "LOB"
        case lptParagraph47 = "LPT §47"
        case ss = "SS"
        case amb = "AMB"
        case pam = "PAM"
        case remissFrom = "Remiss from"
    }
    
    enum SuicidalRiskNiveau: String, CaseIterable {
        case low, little, medium, high
        
        var nivea: String {
            return rawValue.capitalized
        }
    }
    
    enum ViolenceRiskNiveau: String, CaseIterable {
        case low, medium, high
        
        var nivea: String {
            return rawValue.capitalized
        }
    }
    
    enum TypesOfObservation: String, CaseIterable {
        case normal = "normal"
        case xobs = "X-OBS"
        case xvak = "X-VAK"
        case xvakXobs = "X-VAK/X-OBS"
    }
    
    
    struct Medicine {
        enum Form: String, CaseIterable {
            case capsule, tablet, liquid, topical, cream, device, drops, foam, gel, inhaler, injection, lotion, ointment, patch, powder, spray, suppository
            
            var name: String {
                return rawValue.capitalized
            }
        }
        
        enum Unit: String, CaseIterable {
            case milliGram = "mg"
            case mikroGram = "µg"
            case gram = "g"
            case milliLiter = "ml"
            case procent = "%"
        }
        
        enum Frequency: String, CaseIterable {
            case atRegularIntervals = "At Regular Intervals"
            case onSpecificDaysOfTheWeek = "On Specific Days of the Week"
            case asNeeded = "As Needed"
        }
        
        enum ChosenInterval: String, CaseIterable {
            case day = "Day"
            case otherDay = "Other Day"
            case threeDays = "3 Days"
            case fourDays = "4 Days"
            case ninetyNineDays = "99 Days"
        }
        
        enum ChosenDay: String, CaseIterable {
            case Monday = "Mon"
            case Tuesday = "Tue"
            case Wednesday = "Wed"
            case Thursday = "Thu"
            case Friday = "Fri"
            case Saturday = "Sat"
            case Sunday = "Sun"
        }
        
        let startDate = Date.now
    }
}
