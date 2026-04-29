//
//  IteractorView.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 17.04.2026.
//

import Foundation

class InteractorMain: IInteractorMain {
    
    weak var presenter: IPresenterMain?
    var repository: IToDoRepository
    
    var todos: [ToDo] {
        get {
            repository.todos
        }
    }
    
    init(presenter: IPresenterMain?) {
        self.presenter = presenter
        repository = ToDoRepository.shared
        repository.delegate = presenter as? ToDoRepositoryDelegate
    }
    
    func setCompletion(index: Int) {
        repository.todos[index].completed = !repository.todos[index].completed
    }
    
    func getTodo(index: Int) -> ToDo? {
        repository.todos[index]
    }
}

protocol IInteractorMain {
    var presenter: IPresenterMain? { get }
    var repository: IToDoRepository { get }
    func setCompletion(index: Int)
    func getTodo(index: Int) -> ToDo?
}
