//
//  ContentView.swift
//  toDoApp
//
//  Created by Илья on 21.12.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject private var todoListVM = ToDoListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter title", text: $todoListVM.todoTitle)
                    .textFieldStyle(.roundedBorder)
                
                Picker("Priority", selection: $todoListVM.selectedPriority) {
                    Text("Low").tag("low")
                    Text("Medium").tag("medium")
                    Text("High").tag("high")
                }.pickerStyle(.segmented)
                
                Button("Add Task") {
                    todoListVM.createTodoItem()
                }.padding(.top, 10)
                
                
                List {
                    ForEach(todoListVM.todoItems) { todoItem in
                        HStack {
                            Text(todoItem.title)
                            Spacer()
                            Text(todoItem.priority)
                        }
                        
                    }.onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let todoItem = todoListVM.todoItems[index]
                            todoListVM.deleteTodoItems(todoItem)
                        }
                    })
                }.onAppear(perform: {
                    todoListVM.populateTodos()
                })
                .navigationTitle("ToDos")
            }.padding()
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
