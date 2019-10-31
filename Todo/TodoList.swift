//
//  TodoList.swift
//  Todo
//
//  Created by Сергей Бородин on 25.10.2019.
//  Copyright © 2019 Сергей Бородин. All rights reserved.
//

import Foundation

class TodoList: ObservableObject{
    @Published var list = [Task]()
    
    init(){
    }
    
    init(to list: [Task]){
        self.list = list
    }
}

var g_list = TodoList(to: [
    Task(name: "Вынести мусор"),
    Task(name: "Запилить прилагу"),
    Task(name: "Сказать Васе, что поработал вчера"),
    Task(name: "Поиграть на работе в Героев"),
])
