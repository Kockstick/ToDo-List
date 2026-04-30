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
        todo.completed = !todo.completed
    }
}

protocol IInteractorMain {
    var presenter: IPresenterMain? { get }
    var repository: IToDoRepository? { get }
    func setCompletion(todo: ToDoEntity)
}
