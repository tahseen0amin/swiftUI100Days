//
//  AstronautView.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 08/01/2020.
//  Copyright © 2020 Taazuh. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    var astronaut: Astronaut
    var missionsFlew: [Mission]
    
    var body: some View {
        GeometryReader { goemetry in
            ScrollView(.vertical){
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: goemetry.size.width)
                    
                    Text(self.astronaut.description).padding()
                    
                    Text("Missions Flew").font(.title)
                    
                    ForEach(self.missionsFlew) { mission in
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding()
                            
                            Text(mission.displayName).font(.headline)
                            
                            Spacer()
                            
                        }.padding(.horizontal)
                    }
                    
                    Spacer(minLength: 30)
                    
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        let missions: [Mission] = Bundle.main.decode(file: "missions.json")
        
        missionsFlew = missions.filter {
            $0.crew.contains { $0.name == astronaut.id}
        }
        
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astr: [Astronaut] = Bundle.main.decode(file: "astronauts.json")
    
    static var previews: some View {
        NavigationView {
            AstronautView(astronaut: astr[10])
        }
        
    }
}
