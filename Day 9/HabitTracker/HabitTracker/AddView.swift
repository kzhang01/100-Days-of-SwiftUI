//
//  AddView.swift
//  HabitTracker
//
//  Created by Karina Zhang on 1/1/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities
    @State private var name = ""
    @State private var description = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add an entry")
            .navigationBarItems(trailing: Button("Save") {
                let item = Activity(name: self.name, description: self.description, timesCompleted: 0)
                self.activities.items.append(item)
                self.presentationMode.wrappedValue.dismiss()
                
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(activities: Activities())
    }
}
