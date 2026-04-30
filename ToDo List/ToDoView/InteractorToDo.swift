//
//  InteractorToDo.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 17.04.2026.
//

class InteractorToDo: IInteractorToDo {
    weak var presenter: IPresenterToDo?
    
    init(presenter: IPresenterToDo?) {
        self.presenter = presenter
    }
    
    func save(todo: ToDoEntity) {
        let context = CoreDataStack.shared.viewContext
        do{
            try context.save()
        } catch {
            print("Error save todo: \(error.localizedDescription)")
        }
    }
}

protocol IInteractorToDo: AnyObject {
    var presenter: IPresenterToDo? { get }
    func save(todo: ToDoEntity)
}
