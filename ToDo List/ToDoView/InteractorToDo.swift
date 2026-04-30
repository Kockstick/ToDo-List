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
}

protocol IInteractorToDo: AnyObject {
    var presenter: IPresenterToDo? { get }
}
