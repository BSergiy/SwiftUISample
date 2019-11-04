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
    
    private var yearInSeconds: Double { 365.0 * 24.0 * 60.0 * 60.0 }

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

            VStack(alignment: .leading){
                Text("Приоритет:")
                Picker(
                    selection: $task.priority,
                    label: Text("Приоритет:")
                ){
                    ForEach(Priority.allCases, id: \.self) {
                        self.makePriorityImage($0)
                            .tag($0)
                    }
                }
                    .pickerStyle(SegmentedPickerStyle())
            }.padding()

            VStack(alignment: .leading){
                Text("Дата экспирации:")
                DatePicker(
                    selection: $task.expiration,
                    in: Date()...Date().addingTimeInterval(yearInSeconds),
                    displayedComponents: .date
                ){
                    Text("")
                }
            }.padding()

            Divider()
            
            makeDoneButton().padding()
            
            Spacer()
        }
            .padding()
    }
    
    func makePriorityImage(_ priority: Priority) -> Image {
        let rawImage = UIImage(systemName: "flame")!
        let coloredImage: UIImage;
        
        switch priority {
        case .low:
            coloredImage = rawImage.withTintColor(.gray, renderingMode: .alwaysOriginal)
        case .normal:
            coloredImage = rawImage.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        case .high:
            coloredImage = rawImage.withTintColor(.red, renderingMode: .alwaysOriginal)
        }
        
        return Image(uiImage: coloredImage)
    }
    
    func makeDoneButton() -> some View {
        if id != nil {
            return Button(action: editTask){
                Text("Редактировать")
            }
        }
        
        return Button(action: createNewTask){
            Text("Создать")
        }
    }
    
    func editTask(){
        guard let index = todoList.list.firstIndex(where: { $0.id == id }) else{
            return
        }
        
        todoList.list[index] = task
        todoList.saveToUserFolder()
        presentationMode.wrappedValue.dismiss()
    }
    
    func createNewTask(){
        todoList.list.append(task)
        todoList.saveToUserFolder()
        presentationMode.wrappedValue.dismiss()
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: Task())
    }
}
