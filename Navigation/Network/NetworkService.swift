//
//  NetworkService.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 03.09.2023.
//

import Foundation

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        let url:URL
        switch configuration {
        case .starships:
            url = URL(string: configuration.rawValue)!
        case .people:
            url = URL(string: configuration.rawValue)!
        case .planets:
            url = URL(string: configuration.rawValue)!
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) {data , response, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("All headers is \(httpResponse.allHeaderFields)")
                print("Status code is \(httpResponse.statusCode)")
            }
            guard let data else {
                print("Data is empty")
                return
            }
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data)
                print("Data is \(jsonData)")
            }catch {
                print("JSON serialization error is \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
