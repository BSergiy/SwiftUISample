//
//  File.swift
//  Todo
//
//  Created by Сергей Бородин on 25.10.2019.
//  Copyright © 2019 Сергей Бородин. All rights reserved.
//

import Foundation

enum Priority: String, CaseIterable, Codable, Hashable, Comparable{
    case high = "Высокий"
    case normal = "Нормальный"
    case low = "Низкий"
    
    static func >(p1: Priority, p2: Priority) -> Bool{
        let p1Weidth = p1 == .high ? 1 : (p1 == .normal ? 0 : -1)
        let p2Weidth = p2 == .high ? 1 : (p2 == .normal ? 0 : -1)
        
        return p1Weidth > p2Weidth
    }
    
    static func <(p1: Priority, p2: Priority) -> Bool{
        let p1Weidth = p1 == .high ? 1 : (p1 == .normal ? 0 : -1)
        let p2Weidth = p2 == .high ? 1 : (p2 == .normal ? 0 : -1)
        
        return p1Weidth < p2Weidth
    }
}

struct Task: Hashable, Codable, Identifiable{
    let id = UUID()
    var name = ""
    var description = ""
    var priority: Priority = .normal
    var expiration = Date()
    let created = Date()
}
