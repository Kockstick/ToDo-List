//
//  IteractorView.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 17.04.2026.
//

import Foundation

class InteractorMain: IInteractorMain {
    
    weak var presenter: IPresenterMain?
    weak var repository: IToDoRepository?
    
    init(presenter: IPresenterMain?) {
        self.presenter = presenter
    }
    
    func setCompletion(todo: ToDoEntity) {
        let context = CoreDataStack.shared.viewContext
        context.performAndWait {
            todo.completed = !todo.completed
            
            do{
                try context.save()
            } catch {
                print("Error change completion todo: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteTodo(todo: ToDoEntity){
        let context = CoreDataStack.shared.viewContext
        context.performAndWait {
            context.delete(todo)
            
            do{
                try context.save()
            } catch {
                print("Error delete entity: \(error.localizedDescription)")
            }
        }
    }
}

protocol IInteractorMain {
    var presenter: IPresenterMain? { get }
    var repository: IToDoRepository? { get }
    func setCompletion(todo: ToDoEntity)
    func deleteTodo(todo: ToDoEntity)
}
