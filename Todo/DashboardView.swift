//
//  Dashboard.swift
//  Todo
//
//  Created by Сергей Бородин on 25.10.2019.
//  Copyright © 2019 Сергей Бородин. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var todoList: TodoList

    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(todoList.list){ task in
                        self.makeTaskRow(task)
                    }
                        .onDelete(perform: deleteItems)
                        .frame(minHeight: 70)
                }

                HStack{
                    Spacer()
                    NavigationLink(
                        destination: makeTaskView(Task())
                    ){
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }.padding()
            }.navigationBarTitle("Список задач",
                                 displayMode: .inline)
        }.navigationBarItems(trailing: EditButton())
    }
    
    private func deleteItems(at offsets: IndexSet) {
        todoList.list.remove(atOffsets: offsets)
        todoList.saveToUserFolder()
    }
    
    private func makeTaskView(_ task: Task, withId: Bool = false) -> some View{
        if withId {
            return TaskView(task: task, id: task.id).environmentObject(self.todoList)
        }
        else
        {
            return TaskView(task: task).environmentObject(self.todoList)
        }
    }

    private func makeTaskRow(_ task: Task) -> some View{
        NavigationLink(destination: makeTaskView(task, withId: true)){
            HStack{
                makePriorityTagView(task.priority)
                
                VStack(alignment: .leading){
                    Text(task.name)
                        .font(.title)
                    if (!task.description.isEmpty){
                        Text(task.description)
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    private func drawCircle() -> some View{
        Circle()
            .frame(width: 20, height: 20)
            .fixedSize()
    }
    
    private func makePriorityTagView(_ priprity: Priority) -> some View{
        switch priprity {
        case .low:
            return drawCircle().foregroundColor(.gray)
        case .normal:
            return drawCircle().foregroundColor(.yellow)
        case .high:
            return drawCircle().foregroundColor(.red)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView().environmentObject(TodoList())
    }
}
