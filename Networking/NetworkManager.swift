//
//  NetworkManager.swift
//  Networking
//
//  Created by Асанцев Владимир Дмитриевич on 07.01.2022.
//

import Foundation

class NetworkManager {
    
    enum HTTPMethod: String {
        case POST
        case PUT
        case GET
        case DELETE
    }
    
    enum APIs: String {
        case posts
        case users
        case comments
    }
    
    private let baseURL = "https://jsonplaceholder.typicode.com/"
    
    
    func getAllPosts(_ completionHandler: @escaping ([Post]) -> ()) {
        if let url = URL(string: baseURL + APIs.posts.rawValue) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("error in request")
                } else {
                    if let response = response as? HTTPURLResponse, response.statusCode == 200,
                       let responseData = data {
                        let posts = try? JSONDecoder().decode([Post].self, from: responseData)
                        completionHandler(posts ?? [])
                    }
                }
            }.resume()
        }
    }
    
    func postCreatePost(_ post: Post, completionHandler: @escaping (Post) -> ()) {
        
        let sendData = try? JSONEncoder().encode(post)
        
        guard let url = URL(string: baseURL + APIs.posts.rawValue),
        let data = sendData else { return }
        let request = MutableURLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length") //сколько байтов я отправляю серверу (длина даты)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") //тип данных json (а не xml)
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                print("error")
            } else if let resp = response as? HTTPURLResponse, resp.statusCode == 201, let responseData = data {
                
                let json = try? JSONSerialization.jsonObject(with: responseData) //конвертируем байты, пришедшие в ответе, в json.
                print(">>> json: \(json)")
                
                if let responsePost = try? JSONDecoder().decode(Post.self, from: responseData) {
                    completionHandler(responsePost)
                }
            }
        }.resume()
                
    }
}
