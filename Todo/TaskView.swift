//
//  TaskView.swift
//  Todo
//
//  Created by Сергей Бородин on 25.10.2019.
//  Copyright © 2019 Сергей Бородин. All rights reserved.
//

import SwiftUI

struct TaskView: View {
    @State var task: Task
    var id: UUID? = nil
    @EnvironmentObject var todoList: TodoList
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack{
            HStack{
                Text("Название:")
                TextField("", text: $task.name)
            }.padding()
            
            HStack{
                Text("Описание:")
                TextField("", text: $task.description)
            }.padding()

            if self.id != nil {
                Button(action: editTask){
                    Text("Редактировать")
                }
            }
            else{
                Button(action: createNewTask){
                    Text("Создать")
                }
            }
            
            Spacer()
        }
            .padding()
    }
    
    func editTask(){
        guard let index = self.todoList.list.firstIndex(where: { $0.id == self.id }) else{
            return
        }
        
        self.todoList.list[index] = self.task
        self.todoList.saveToUserFolder()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func createNewTask(){
        self.todoList.list.append(self.task)
        self.todoList.saveToUserFolder()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: Task())
    }
}
