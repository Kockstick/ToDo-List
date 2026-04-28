//
//  ToDo.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 28.04.2026.
//

import Foundation

struct ToDo: Codable {
    var id: Int32
    var title: String?
    var todo: String
    var userId: Int32
    var completed: Bool
    var date: Date? = Date.now
}
