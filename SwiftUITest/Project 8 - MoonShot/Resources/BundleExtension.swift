//
//  BundleExtension.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 07/01/2020.
//  Copyright © 2020 Taazuh. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        
        // get the file url
        guard let fileURL = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate the \(file) in the bundle.")
        }
        
        // get the content of the file
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("Failed to load the content of \(file).")
        }
        
        // decode the file
        let jsonDecoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let content = try? jsonDecoder.decode(T.self, from: data) else {
            fatalError("Failed to decode the content of \(file).")
        }
        
        return content
    }
}
