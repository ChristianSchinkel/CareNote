//
//  RemindersView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-11-04.
//

import SwiftUI

struct RemindersView: View {
    // MARK: - local State properties
    @Binding var asNeeded: Bool // Whether the medicine kan admit as needed or not
    
    @Binding var isRepeating: Bool // Reminders-list is showing.
    @State private var frequency: Care.Medicine.Frequency = .asNeeded
    @State private var chosenInterval: Care.Medicine.ChosenInterval = .day
    @State private var chosenDay: Care.Medicine.ChosenDay = .Monday
    @State private var time: Date = Date.now
    // MARK: - Body
    var body: some View {
        Section("Reminders") {
            Picker(selection: $frequency, label: Text("\(frequency.rawValue)")) {
                ForEach(Care.Medicine.Frequency.allCases) { freq in
                    Text(freq.rawValue)
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
            
            if asNeeded {
                } else {
                Picker(selection: $chosenInterval, label: Text("\(chosenInterval.rawValue)")) {
                    ForEach(Care.Medicine.ChosenInterval.allCases) { interval in
                        Text(interval.rawValue)
                    }
                }
                .pickerStyle(.wheel)
                .labelsHidden()
                
                Picker(selection: $chosenDay, label: Text("\(chosenDay.rawValue)")) {
                    ForEach(Care.Medicine.ChosenDay.allCases) { day in
                        Text(day.rawValue)
                    }
                }
                .pickerStyle(.navigationLink)
                .labelsHidden()
                
                    DatePicker("Reminder-Time", selection: $time, displayedComponents: .hourAndMinute)
            }
        
            
        }
    }
}
// MARK: - Previews
struct RemindersView_Previews: PreviewProvider {
    @State static private var isRepeating: Bool = false // Reminders-list
    @State static private var asNeeded: Bool = false // Whether the medicine kan admit as needed or not
    
    static var previews: some View {
        RemindersView(asNeeded: self.$asNeeded, isRepeating: self.$isRepeating)
    }
}
