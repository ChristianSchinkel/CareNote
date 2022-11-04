//
//  PreScriptionDurationView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-11-04.
//

import SwiftUI

struct PreScriptionDurationView: View {
    // MARK: - local State properties
    @Binding var isPrescripted: Bool // Is the medicine prescripted or not.
    @Binding var treatmentDurationEndDate: Date // When prescription ends.
    @Binding var reasonOfPrescribing: Care.Medicine.ReasonOfPrescribing // Why the medicine i used.
    @Binding var treatmentDurationEndReason: Care.Medicine.TreatmentDurationEndReason // Why treatment stops.
    @Binding var treatmentDurationStartDate: Date // When prescription starts.
    // MARK: - Body
    var body: some View {
        Section("Prescription starts & ends") {
            Toggle(isOn: $isPrescripted) {
                Text("Prescription") // is prescripted? Yes/No.
            }
            
            DatePicker("Treatment starts on:", selection: $treatmentDurationStartDate) // when to start.
            Picker(selection: $reasonOfPrescribing, label: Text("Reason of treatment")) {
                ForEach(Care.Medicine.ReasonOfPrescribing.allCases) { reason in
                    Text(reason.rawValue) // Why chosen treatment?
                }
            }
            
            
            DatePicker("Treatment ends on:", selection: $treatmentDurationEndDate) // when to stop.
            Picker(selection: $treatmentDurationEndReason, label: Text("Reason to for stopping")) {
                ForEach(Care.Medicine.TreatmentDurationEndReason.allCases) { reason in
                    Text(reason.rawValue)
                }
            }
            
        }
    }
}
// MARK: - Previews
struct PreScriptionDurationView_Previews: PreviewProvider {
    @State static private var isPrescripted: Bool = false // Is the medicine prescripted or not.
    @State static private var treatmentDurationEndDate: Date = Date.distantFuture // When prescription ends.
    @State static private var reasonOfPrescribing: Care.Medicine.ReasonOfPrescribing = .other // Why the medicine i used.
    @State static private var treatmentDurationEndReason: Care.Medicine.TreatmentDurationEndReason = .plannedStop // Why treatment stops.
    @State static private var treatmentDurationStartDate: Date = Date.now // When prescription starts.
    
    static var previews: some View {
        PreScriptionDurationView(isPrescripted: self.$isPrescripted, treatmentDurationEndDate: self.$treatmentDurationEndDate, reasonOfPrescribing: self.$reasonOfPrescribing, treatmentDurationEndReason: self.$treatmentDurationEndReason, treatmentDurationStartDate: self.$treatmentDurationStartDate)
    }
}
