//
//  ContentView.swift
//  Moonshot
//
//  Created by Karina Zhang on 12/31/20.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State var showDate = true

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, missions: self.missions)) {
                    
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if self.showDate {
                            Text(mission.formattedLaunchDate)
                        }
                        else {
                            HStack {
                                Text("Crew Names: \(mission.crewNames)")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showDate.toggle()
                }, label: {
                    Text("Show \(self.showDate ? "crew" : "date")")
                })
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
