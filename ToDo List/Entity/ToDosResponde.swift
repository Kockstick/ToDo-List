//
//  ToDosResponde.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 24.04.2026.
//

struct ToDosResponde: Codable{
    let todos: [ToDoDTO]
    let total: Int
    let skip: Int
    let limit: Int
}
