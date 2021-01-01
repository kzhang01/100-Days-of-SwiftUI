//
//  AstronautView.swift
//  Moonshot
//
//  Created by Karina Zhang on 12/31/20.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var missions: [Mission]

    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        self.missions = missions
        var matches = [Mission]()
        for mission in missions {
            if let match = mission.crew.first(where: {$0.name == self.astronaut.id}) {
                matches.append(mission)
            }
        }
        self.missions = matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    ForEach(self.missions) { mission in
                        HStack {
                            Image(mission.image)
                                .resizable()
                            .scaledToFit()
                                .frame(width: 75, height: 75)

                            Text(mission.displayName)
                                .font(.headline)

                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
