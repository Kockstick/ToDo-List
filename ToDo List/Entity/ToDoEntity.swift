//
//  ToDoEntity+CoreDataClass.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 28.04.2026.
//
//

import Foundation

extension ToDoEntity {
    func toModel() -> ToDoDTO {
        ToDoDTO(id: id, title: title, todo: todo ?? "", userId: userId, completed: completed, date: date)
    }
    
    func update(from model: ToDoDTO) {
        title = model.title
        todo = model.todo
        userId = model.userId
        completed = model.completed
        date = model.date
    }
    
    func create(from model: ToDoDTO) {
        title = model.title
        todo = model.todo
        date = Date.now
        completed = false
    }
}
