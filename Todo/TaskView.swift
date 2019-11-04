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
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }

    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text("Название:")
                    TextField("", text: $task.name)
                        .background(Color(UIColor(white: 0.0, alpha: 0.05)))
                }.padding([Edge.Set.horizontal, Edge.Set.top])

                VStack(alignment: .leading){
                    Text("Описание:")
                    TextView(text: $task.description)
                        .frame(
                            minWidth: 10,
                            maxWidth: .infinity,
                            minHeight: 80,
                            maxHeight: .infinity
                        )
                }.padding(Edge.Set.horizontal)

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
                }.padding(Edge.Set.horizontal)

                HStack{
                    Text("Выбор даты экспирации:")
                    NavigationLink(
                        destination: makeExpirationDatePicker(from: task.created)
                    ){
                        Text("\(task.expiration, formatter: dateFormatter)")
                    }.padding()
                }

                Divider()
                
                makeDoneButton().padding(Edge.Set.horizontal)
                
                Spacer()
            }
        }
    }
    
    private func makeExpirationDatePicker(from date: Date) -> some View{
        DatePicker(
            selection: $task.expiration,
            in: date...Date().addingTimeInterval(yearInSeconds),
            displayedComponents: .date
        ){
            Text("")
        }.navigationBarTitle("Выбор даты экспирации")
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
