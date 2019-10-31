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
                    ForEach(todoList.list, id: \.id){ task in
                        NavigationLink(destination: TaskView(task: task, id: task.id).environmentObject(self.todoList)){
                            Text(task.name)
                        }
                    }
                }
                HStack{
                    Spacer()
                    NavigationLink(destination: TaskView(task: Task()).environmentObject(todoList)){
                        Text("Создать")
                    }
                }.padding()
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView().environmentObject(TodoList())
    }
}
