//
//  LawPickerView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-12.
//

import SwiftUI

struct LawPickerView: View {
    
    @Binding var law: String // '@Binding' sents back its information to the relevant parent's '@State'-property (can be 'private', but doesn't need to).
    @Binding var date: Date // '@Binding' sents back its information to the relevant parent's '@State'-property (can be 'private', but doesn't need to).
    
    var body: some View {
        
        VStack {
            Picker(selection: $law, label: Text("Type of Care by Law")) {
                ForEach(AddPatientView.laws, id: \.self) { law in
                    Text(law)
                }
            }
            DatePicker(selection: $date, label: { Text("Arrived:").foregroundColor(.secondary) })
        }
    }
}

struct LawPickerView_Previews: PreviewProvider {
    static private let laws = Care().laws
    @State static private var date = Date.now
    @State static private var law = laws[0]
    
    static var previews: some View {
        LawPickerView(law: self.$law, date: self.$date)
    }
}
