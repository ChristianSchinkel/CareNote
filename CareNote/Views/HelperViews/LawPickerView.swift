//
//  LawPickerView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-12.
//

import SwiftUI

struct LawPickerView: View {
    
    @Binding var law: Care.Laws // '@Binding' sents back its information to the relevant parent's '@State'-property (can be 'private', but doesn't need to).
    @Binding var date: Date // '@Binding' sents back its information to the relevant parent's '@State'-property (can be 'private', but doesn't need to).
    
    var body: some View {
        
        VStack {
            Picker(selection: $law, label: Text("Type of Care by Law")) {
                ForEach(Care.Laws.allCases, id: \.self) { law in
                    Text(law.rawValue)
                }
            }
            DatePicker(selection: $date, label: { Text("Arrived:").foregroundColor(.secondary) })
        }
    }
// MARK: - Functions for this View:
}

struct LawPickerView_Previews: PreviewProvider {
    static private let laws = Care()
    @State static private var date = Date.now
    @State static private var law = Care.Laws.HSL
    
    static var previews: some View {
        LawPickerView(law: self.$law, date: self.$date)
    }
}
