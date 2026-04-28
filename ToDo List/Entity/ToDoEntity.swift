//
//  ToDo+CoreDataClass.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 28.04.2026.
//
//

import Foundation
import CoreData

@objc(ToDoEntity)
public final class ToDoEntity: NSManagedObject {

}

extension ToDoEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoEntity> {
        return NSFetchRequest<ToDoEntity>(entityName: "ToDo")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var date: Date?
    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var todo: String
    @NSManaged public var userId: Int32

}

extension ToDoEntity : Identifiable {
    func toModel() -> ToDo {
        ToDo(id: id, title: title, todo: todo, userId: userId, completed: completed, date: date)
    }
    
    func update(from model: ToDo) {
        id = model.id
        title = model.title
        todo = model.todo
        userId = model.userId
        completed = model.completed
        date = model.date
    }
}
