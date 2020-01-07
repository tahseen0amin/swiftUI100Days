//
//  MoonshotView.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 07/01/2020.
//  Copyright © 2020 Taazuh. All rights reserved.
//

import SwiftUI

struct MoonshotView: View {
    let astronauts: [Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    
    var body: some View {
        NavigationView {
            List(missions){ mission in
                NavigationLink(destination: MissionDetailView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .padding()
                    VStack (alignment: .leading) {
                        Text(mission.displayName).font(.headline).padding(.bottom)
                        Text(mission.launchDateFormatted).font(.subheadline)
                    }
                }
            }
            .navigationBarTitle("Moonshot")
        }
    }
}

struct MoonshotView_Previews: PreviewProvider {
    static var previews: some View {
        MoonshotView()
    }
}
