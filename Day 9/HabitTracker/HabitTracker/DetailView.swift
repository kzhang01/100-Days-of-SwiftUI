//
//  DetailView.swift
//  HabitTracker
//
//  Created by Karina Zhang on 1/1/21.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var activities: Activities
    @State private var timesCompleted = 0
    @State private var showingAlert = false
    var activity: Activity
    
    var body: some View {
        Form {
            Section(header: Text("Description for activity")) {
                Text("\(self.activity.description)")
            }
            
            Section(header: Text("Change Completed Times")) {
                Stepper(value: $timesCompleted, in: 0...Int.max, step: 1) {
                    Text("Completed times: \(self.timesCompleted)")
                }
            }
        }
        .navigationBarTitle(Text("\(self.activity.name)"))
        .navigationBarItems(trailing: Button(action: {
            self.saveActivity()
        }, label: {
            Text("Save")
        }))
            .onAppear {
                self.timesCompleted = self.activity.timesCompleted
        }
        
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text("Something's gone wrong :( Try reloading the app"), dismissButton: .default(Text("OK")))
        }
    }
    
    func saveActivity() {
        var indexItem = -1
        for n in 0...activities.items.count - 1 {
            if activities.items[n].name == self.activity.name &&
                activities.items[n].description == self.activity.description {
                indexItem = n
            }
        }
        
        if indexItem < 0 {
            self.showingAlert = true
        }

        let tempActivity = Activity(name: self.activity.name,
                                    description: self.activity.description,
                                    timesCompleted: self.timesCompleted)
    
        self.activities.items.remove(at: indexItem)
        self.activities.items.insert(tempActivity, at: indexItem)
        self.activities.saveActivities()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(activities: Activities(), activity: Activity(name: "Name", description: "Description", timesCompleted: 0))
    }
}
