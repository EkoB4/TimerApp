//
//  UiPicker.swift
//  AlarmApp
//
//  Created by VB on 11.05.2022.
//

import SwiftUI

struct UIPicker : View {
    @State private var selection = 0
    let times = [10,20,30,40]
    var body: some View{
        Picker(selection: $selection, label: Text("sa")) {
            Text(self.times)
        }
    }
}

struct UIPicker_previews : PreviewProvider{
    static var previews: some View{
        UIPicker()
    }
}
