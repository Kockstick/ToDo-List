//
//  ToDo.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 28.04.2026.
//

import Foundation

struct ToDoDTO: Codable {
    var id: Int32
    var title: String?
    var todo: String
    var userId: Int32
    var completed: Bool
    var date: Date? = Date.now
    
    init(id: Int32, title: String? = nil, todo: String, userId: Int32, completed: Bool, date: Date? = nil) {
        self.id = id
        self.title = title
        self.todo = todo
        self.userId = userId
        self.completed = completed
        self.date = date
    }
    
    init(title: String, todo: String){
        id = 0
        self.title = title
        self.todo = todo
        userId = 0
        completed = false
        date = Date.now
    }
}

extension Date{
    private static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd/MM/yy"
        return f
    }()
    
    var formattedDate: String {
        Date.formatter.string(from: self)
    }
}
