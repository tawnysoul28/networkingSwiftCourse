//
//  Post.swift
//  Networking
//
//  Created by Асанцев Владимир Дмитриевич on 07.01.2022.
//

import Foundation

class Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
    init(userId: Int, title: String, body: String) {
        self.userId = userId
        self.title = title
        self.body = body
        self.id = 0 //пост создан только на клиенте и сервер не подтвертид его создание
    }
}
