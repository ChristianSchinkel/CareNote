//
//  CareData.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-18.
//

import Foundation
/// Care-struct declared in CareData.swift is a struct that has much information and is very central in the app using it.
struct Care {
    /// Aimed to triage the importans of interaction to support the patient.
    enum PriorityTriage: String {
    case green, yellow, orange, red, blue
    }
    /// Swedish laws associated with healthcare; often used in closed mental-health.
    enum Laws: String, CaseIterable {
        case HSL, LPT, LVM, LVU, LRV
    }
    ///  How a patient comes into hospital.
    enum HowPatientComeIn: String, CaseIterable {
        case police = "Police"
        case lob = "LOB"
        case lptParagraph47 = "LPT §47"
        case ss = "SS"
        case amb = "AMB"
        case pam = "PAM"
        case remissFrom = "Remiss from"
    }
    /// How high is the risk that a patient commit a potential suicidal action on a scale from low to high.
    enum SuicidalRiskNiveau: String, CaseIterable {
        case low, little, medium, high
        
        var nivea: String {
            return rawValue.capitalized
        }
    }
    /// How high is the potential risk a patient will harm somebody or furniture.
    enum ViolenceRiskNiveau: String, CaseIterable {
        case low, medium, high
        
        var nivea: String {
            return rawValue.capitalized
        }
    }
    ///  How intense staff need to watch a patient. Normal: like all patients. X-OBS: every 15th minute. X-VAK: All the time. X-VAK/X-OBS: relies on previous but only when the patient is awake.
    enum TypesOfObservation: String, CaseIterable {
        case normal = "normal"
        case xobs = "X-OBS"
        case xvak = "X-VAK"
        case xvakXobs = "X-VAK/X-OBS"
    }
    
    /// Medicine-Struct with information to create a prescription of a medicine.
    struct Medicine {
//        var name: String
        /// Form of a medicine.
        enum Form: String, CaseIterable, Identifiable {
            case capsule, tablet, liquid, topical, cream, device, drops, foam, gel, inhaler, injection, lotion, ointment, patch, powder, spray, suppository, none
            
            var id: Self { self } // --> (id: \.self )
            
            var name: String {
                return rawValue.capitalized
            }
        }
        /// Unit of a medicine.
        enum Unit: String, CaseIterable, Identifiable {
            case milliGram = "mg"
            case mikroGram = "µg"
            case gram = "g"
            case milliLiter = "ml"
            case procent = "%"
            case none = "-"
            
            var id: Self { self } // --> (id: \.self )
        }
        /// Mode of administration
        enum ModeOfAdministration: String, CaseIterable, Identifiable {
            case oral, im, iv, sc
            
            var id: Self { self } // --> (id: \.self )
        }
        /// Reason of prescribing
        enum ReasonOfPrescribing: String, CaseIterable, Identifiable {
        case sleep, other
            
            var id: Self { self } // --> (id: \.self )
        }
        /// The reason why the treatment ends
        enum TreatmentDurationEndReason: String, CaseIterable, Identifiable {
            case plannedStop
            
            var id: Self { self } // --> (id: \.self )
        }
        /// Frequency.
        enum Frequency: String, CaseIterable, Identifiable {
            case atRegularIntervals = "At Regular Intervals"
            case onSpecificDaysOfTheWeek = "On Specific Days of the Week"
            case asNeeded = "As Needed"
            
            var id: Self { self } // --> (id: \.self )
        }
        /// Interval.
        enum ChosenInterval: String, CaseIterable, Identifiable {
            case day = "Day"
            case otherDay = "Other Day"
            case threeDays = "3 Days"
            case fourDays = "4 Days"
            case ninetyNineDays = "99 Days"
            
            var id: Self { self } // --> (id: \.self )
        }
        /// WeekDay.
        enum ChosenDay: String, CaseIterable, Identifiable {
            case Monday = "Mon"
            case Tuesday = "Tue"
            case Wednesday = "Wed"
            case Thursday = "Thu"
            case Friday = "Fri"
            case Saturday = "Sat"
            case Sunday = "Sun"
            
            var id: Self { self } // --> (id: \.self )
        }
        /// AdministrationStatus returns a value that represents if the medicine is prescripted, given or skipped.
        enum AdministrationStatus: String {
        case prescripted, given, skipped, taken, none
        }
        /// StartDate that returns Date.now.
        let startDate = Date.now
    }
    /// Patients -Struct is used for texts that are used very often.
    struct Patient {
        /// How is it gong for the patient.
        enum ActivityStatus: String {
            case awake, sleeping
        }
    }
}
