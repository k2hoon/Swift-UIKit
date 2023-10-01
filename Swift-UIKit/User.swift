//
//  User.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/30.
//

import Foundation

struct User: Decodable, Hashable {
    let id: Int
    let name: String
    let description: String
}
