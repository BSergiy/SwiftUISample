//
//  File.swift
//  Todo
//
//  Created by Сергей Бородин on 25.10.2019.
//  Copyright © 2019 Сергей Бородин. All rights reserved.
//

import Foundation

enum Priority: String, CaseIterable, Codable, Hashable{
    case high = "Высокий"
    case normal = "Нормальный"
    case low = "Низкий"
}

struct Task: Hashable, Codable, Identifiable{
    let id = UUID()
    var name = ""
    var description = ""
    var priority: Priority = .normal
    var date: Date? = nil
}
