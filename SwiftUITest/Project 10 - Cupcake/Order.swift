//
//  Order.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 14/01/2020.
//  Copyright © 2020 Taazuh. All rights reserved.
//

import Foundation

class Address: Codable, ObservableObject {
    @Published var name: String = ""
    @Published var streetAddress: String = ""
    @Published var city: String = ""
    @Published var zipCode: String = ""
    
    var validAddress : Bool {
        if isValid(val: name) || isValid(val: streetAddress) || isValid(val: city) || isValid(val: zipCode) {
            return false
        }
        return true
    }
    
    private func isValid(val: String) -> Bool {
        return val.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    enum CodingKeys: CodingKey {
        case name,
        streetAddress,
        city,
        zipCode
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zipCode, forKey: .zipCode)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zipCode = try container.decode(String.self, forKey: .zipCode)
    }
    
    init(){}
}

class Order : ObservableObject, Codable {
    static let types = ["Vanilla", "Strawberry", "Lemon", "Blueberry"]
    
    @Published var type = 0
    @Published var quantity = 1
    
    @Published var hasSpecialRequest = false {
        didSet {
            if hasSpecialRequest == false {
                extraCream = false
                extraSprinkle = false
            }
        }
    }
    @Published var extraCream = false
    @Published var extraSprinkle = false
    @Published var address = Address()
    
    var cost : Double {
        var finalCost = Double (2 * quantity)
        if extraCream {
            finalCost += Double(quantity)
        }
        
        if extraSprinkle {
            finalCost += Double(quantity) * 0.5
        }
        
        finalCost += Double(quantity * ( 1 / (type + 1)))
        
        return finalCost
    }
    
    enum CodingKeys: CodingKey {
        case type,
        extraCream,
        extraSprinkle,
        address,
        quantity
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(extraSprinkle, forKey: .extraSprinkle)
        try container.encode(extraCream, forKey: .extraCream)
        try container.encode(address, forKey: .address)
        try container.encode(quantity, forKey: .quantity)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(Int.self, forKey: .type)
        extraSprinkle = try container.decode(Bool.self, forKey: .extraSprinkle)
        extraCream = try container.decode(Bool.self, forKey: .extraCream)
        address = try container.decode(Address.self, forKey: .address)
        quantity = try container.decode(Int.self, forKey: .quantity)
    }
    
    init() {}
}
