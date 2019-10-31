//
//  File.swift
//  Todo
//
//  Created by Сергей Бородин on 25.10.2019.
//  Copyright © 2019 Сергей Бородин. All rights reserved.
//

import Foundation

enum Priority{
    case high
    case normal
    case low
}

struct Task{
    let id = UUID()
    var name = ""
    var description = ""
    var priority: Priority? = nil
    var date: Date? = nil
}
