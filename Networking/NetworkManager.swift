//
//  NetworkManager.swift
//  Networking
//
//  Created by Асанцев Владимир Дмитриевич on 07.01.2022.
//

import Foundation

class NetworkManager {
    
    func getAllPosts(_ completionHandler: @escaping ([Post]) -> ()) {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts") {
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
}
