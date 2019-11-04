//
//  Dashboard.swift
//  Todo
//
//  Created by Сергей Бородин on 25.10.2019.
//  Copyright © 2019 Сергей Бородин. All rights reserved.
//

import SwiftUI

fileprivate enum SortigType: String, CaseIterable, Hashable{
    case byCreated = "дате создания"
    case byPriority = "приоритету"
    case byExpiration = "дате экспирации"
}

fileprivate enum SortDirection: Int, CaseIterable, Hashable{
    case ascending = 0
    case descending = 1
}

struct DashboardView: View {
    @EnvironmentObject var todoList: TodoList
    
    @State private var showSettings = false
    @State private var sortingType: SortigType = .byCreated
    @State private var sortDirection: SortDirection = .ascending

    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Spacer()
                    
                    Button(action: changeSortDirection){
                        Image(systemName: sortDirection == .ascending ?
                            "arrow.up" : "arrow.down")
                    }
                    
                    Divider().frame(maxHeight: 15)
                    
                    Button(action: { self.showSettings.toggle() }){
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                    .padding()
                
                if (showSettings){
                    dashboardSettings
                        .animation(.default)
                        .transition(.move(edge: .leading))
                }

                Divider()
                
                List{
                    ForEach(todoList.list.sorted(by: sortTasks)){ task in
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
    
    private func sortTasks(t1: Task, t2: Task) -> Bool {
        switch sortingType {
        case .byCreated:
            return compare(t1.created, t2.created)
            
        case.byPriority:
            return compare(t1.priority, t2.priority)
        
        case .byExpiration:
            return compare(t1.expiration, t2.expiration)
        }
    }
    
    private func compare<T: Comparable>(_ t1: T, _ t2: T) -> Bool{
        if (sortDirection == .ascending){
            return t1 > t2
        }
        
        return t1 < t2
    }
    
    private var dashboardSettings: some View{
        VStack{
            Text("Сортировать по:")
            Picker(
                selection: $sortingType,
                label: Text("")
            ){
                ForEach(SortigType.allCases, id: \.self){
                    Text($0.rawValue).tag($0)
                }
            }
                .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    private func changeSortDirection(){
        sortDirection = sortDirection == .ascending ? .descending : .ascending
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
                VStack{
                    makePriorityTagView(task.priority)

                    Text("\(task.expiration, formatter: dateFormatter)")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                
                Divider()
                
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
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView().environmentObject(TodoList())
    }
}
