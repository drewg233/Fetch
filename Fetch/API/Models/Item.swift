//
//  Item.swift
//  Fetch
//
//  Created by Andrew Garcia on 10/20/20.
//

import Foundation

struct Item: Decodable {
    let id: Int
    let listId: Int
    let name: String?
}
