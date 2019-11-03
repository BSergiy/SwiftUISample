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
        do{
            let data = try Data(contentsOf: todoFile)
            
            let decoder = JSONDecoder()
            return try decoder.decode([Task].self, from: data)
        }
        catch{
            print(error)
        }
        return [Task]()
    }
    
    private func saveTasks(tasks: [Task]){
        let fm = FileManager.default
        
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(tasks)
            print(fm.createFile(atPath: todoFile.path, contents: data))
        }
        catch{
            print(error)
        }
    }
    
    private var todoFile: URL {
        let fm = FileManager.default
        
        let appDirectoryName = "todo"
        let fileName = "tasks.json"
        
        do{
            let userDocuments = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
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
            
            return file
        }
        catch{
            fatalError("Что-то пошло не так...")
        }
    }

}

var g_todoList = TodoList()
