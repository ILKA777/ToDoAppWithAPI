//
//  ToDoListViewModel.swift
//  toDoApp
//
//  Created by Илья on 21.12.2023.
//

import Foundation

class ToDoListViewModel: ObservableObject {
    
    @Published var todoTitle: String = ""
    @Published var selectedPriority: String = "medium"
    
    @Published var todoItems = [ToDoItemViewModel]()
    
    func createTodoItem() {
        
        let todo = ToDo(title: todoTitle, priority: selectedPriority)
        WebService().createTodoItem(url: Constants.Urls.createTodoURL, todo: todo) { result in
            switch result {
            case .success(let response):
                if let response = response {
                    if response.success {
                        self.populateTodos()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func deleteTodoItems(_ todoItem: ToDoItemViewModel) {
        
        guard let todoItemId = todoItem.id else {
            return
        }
        
        WebService().deleteTodoItem(url: Constants.Urls.deleteTaskURL(todoItemId)) { result in
            
            switch result {
                case.success(let response):
                if let response = response {
                    if response.success {
                        self.populateTodos()
                    }
                }
                case.failure(let error):
                    print(error)
            }
        }
    }
    
    func populateTodos() {
        WebService().getAllTodos(url: Constants.Urls.allTodosURL) { result in
            switch result {
            case .success(let todos):
                DispatchQueue.main.async {
                    self.todoItems = todos.map(ToDoItemViewModel.init)
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ToDoItemViewModel: Identifiable {
    
    private let todo: ToDo
    
    init(todo: ToDo) {
        self.todo = todo
    }
    
    var id: Int? {
        todo.id
    }
    
    var title: String {
        todo.title
    }
    
    var priority: String {
        todo.priority.uppercased()
    }
    
    
    
}
