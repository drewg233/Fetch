//
//  Int+ParseString.swift
//  Fetch
//
//  Created by Andrew Garcia on 10/20/20.
//

import Foundation

extension Int {
    static func parse(string: String) -> Int {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0
    }
}
