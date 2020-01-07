//
//  MissionDetailView.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 07/01/2020.
//  Copyright © 2020 Taazuh. All rights reserved.
//

import SwiftUI

struct MissionDetailView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    var mission: Mission
    var astronauts: [CrewMember]
    
    @State private var showLaunchDate = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.7)
                        .padding(.top)
                    
                    if self.showLaunchDate {
                        VStack {
                            Text("Launch Date: \(self.mission.launchDateFormatted)")
                            .fontWeight(.bold)
                            .padding(.top)
                        }
                    }
                    
                    Text(self.mission.description)
                        .font(.body)
                        .padding()
                    
                    // crew members
                    if !self.showLaunchDate {
                        VStack {
                            ForEach(self.astronauts, id: \.role) { crewMember in
                                NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                                    HStack {
                                        Image(crewMember.astronaut.id)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 80)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.red))
                                        
                                        VStack(alignment: .leading) {
                                            Text(crewMember.astronaut.name).font(.headline)
                                            Text(crewMember.role).foregroundColor(.secondary)
                                        }
                                        
                                        Spacer()
                                        
                                    }.padding(.horizontal)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
        .navigationBarItems(trailing:
            Button("Toggle"){
                self.showLaunchDate.toggle()
            }
        )
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        self.astronauts = []
        for crewMember in mission.crew {
            if let matched = astronauts.first(where: { crewMember.name == $0.id }) {
                self.astronauts.append(CrewMember(role: crewMember.role, astronaut: matched))
            } else {
                fatalError("Missing Crew Member information")
            }
        }
    }
    
}

struct MissionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let astr: [Astronaut] = Bundle.main.decode(file: "astronauts.json")
        let missions: [Mission] = Bundle.main.decode(file: "missions.json")
        
        return NavigationView {
            MissionDetailView(mission: missions[1], astronauts: astr)
        }

    }
}
