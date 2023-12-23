//
//  WebService.swift
//  toDoApp
//
//  Created by Илья on 21.12.2023.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case badRequest
}

class WebService {
    
    func createTodoItem(url: URL, todo: ToDo, completion: @escaping (Result<GenericResponse?, NetworkError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(todo)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(.badRequest))
                return
            }
            
            let genericResponse = try? JSONDecoder().decode(GenericResponse.self, from: data)
            completion(.success(genericResponse))
            
        }.resume()
    }
    
    
    func deleteTodoItem(url: URL, completion: @escaping (Result<GenericResponse?, NetworkError>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(.badRequest))
                return
            }
            
            let operationResponse = try? JSONDecoder().decode(GenericResponse.self, from: data)
            completion(.success(operationResponse))
            
            
        }.resume()
        
    }
    
    
    func getAllTodos(url: URL, completion: @escaping (Result<[ToDo], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(.badRequest))
                return
            }
            
            let todos = try? JSONDecoder().decode([ToDo].self, from: data)
            completion(.success(todos ?? []))
            
        }.resume()
    }
}
