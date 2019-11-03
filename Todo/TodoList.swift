//
//  TodoList.swift
//  Todo
//
//  Created by Сергей Бородин on 25.10.2019.
//  Copyright © 2019 Сергей Бородин. All rights reserved.
//

import Foundation

fileprivate let appDirectoryName = "todo"
fileprivate let fileName = "tasks.json"

class TodoList: ObservableObject{
    @Published var list = [Task]()
    
    init(){
        list = loadTasks()
    }
    
    init(from list: [Task]){
        self.list = list
    }
    
    func saveToUserFolder(){
        save()
    }
    
    private func save(){
        saveTasks(tasks: list)
    }
    
    private func load(){
        list = loadTasks()
    }
    
    private func loadTasks() -> [Task] {
        let fm = FileManager.default
        
        do{
            let userDocuments = try fm.url(for: .demoApplicationDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let appDirectory = userDocuments.appendingPathComponent(appDirectoryName)
            if (!fm.fileExists(atPath: appDirectory.path)){
                try fm.createDirectory(at: appDirectory, withIntermediateDirectories: true)
            }
            
            let file = appDirectory.appendingPathComponent(fileName)
            
            if (!fm.fileExists(atPath: file.path)){
                let encoder = JSONEncoder()
                let data = try encoder.encode([Task]())
                print(fm.createFile(atPath: file.path, contents: data))
            }
            
            if (fm.fileExists(atPath: file.path)){
                let data = try Data(contentsOf: file)
                
                let decoder = JSONDecoder()
                return try decoder.decode([Task].self, from: data)
            }
            
            return [Task]()
        }
        catch{
            return [Task]()
        }
    }
    
    private func saveTasks(tasks: [Task]){
        let fm = FileManager.default
        
        do{
            let userDocuments = try fm.url(for: .demoApplicationDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let appDirectory = userDocuments.appendingPathComponent(appDirectoryName)
            let file = appDirectory.appendingPathComponent(fileName)
            
            let encoder = JSONEncoder()
            let data = try encoder.encode(tasks)
            print(fm.createFile(atPath: file.path, contents: data))
        }
        catch{
            
        }
        
    }

}

var g_todoList = TodoList()
