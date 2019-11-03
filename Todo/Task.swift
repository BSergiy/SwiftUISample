//
//  File.swift
//  Todo
//
//  Created by Сергей Бородин on 25.10.2019.
//  Copyright © 2019 Сергей Бородин. All rights reserved.
//

import Foundation

enum Priority: String, CaseIterable, Codable, Hashable{
    case high = "high"
    case normal = "normal"
    case low = "low"
}

struct Task: Hashable, Codable, Identifiable{
    let id = UUID()
    var name = ""
    var description = ""
    var priority: Priority? = nil
    var date: Date? = nil
}
