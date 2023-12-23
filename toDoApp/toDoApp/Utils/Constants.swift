//
//  Constants.swift
//  toDoApp
//
//  Created by Илья on 21.12.2023.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let allTodosURL = URL(string: "https://flicker-scratched-soarer.glitch.me/todos")!
        static let createTodoURL = URL(string: "https://flicker-scratched-soarer.glitch.me/todos")!
        
        static func deleteTaskURL(_ taskId: Int) -> URL {
            return URL(string: "https://flicker-scratched-soarer.glitch.me/todos/\(taskId)")!
        }
    }
}
