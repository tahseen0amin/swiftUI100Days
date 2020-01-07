//
//  Mission.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 07/01/2020.
//  Copyright © 2020 Taazuh. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    
    struct CrewMember : Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let description: String
    let launchDate: Date?
    let crew: [CrewMember]
    
    var displayName: String {
        return "Apollo \(self.id)"
    }
    
    var image: String {
        return "apollo\(id)"
    }
    
    var launchDateFormatted: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
