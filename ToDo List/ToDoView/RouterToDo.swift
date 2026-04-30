//
//  RouterToDo.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 17.04.2026.
//

import UIKit

class RouterToDo: IRouterToDo {
    weak var presenter: IPresenterToDo?
    
    init(presenter: IPresenterToDo) {
        self.presenter = presenter
    }
    
    static func build(todo: ToDoEntity) -> UIViewController {
        let view = ViewControllerToDo()
        let presenter = PresenterToDo(view: view)
        let interactor = InteractorToDo(presenter: presenter)
        let router = RouterToDo(presenter: presenter)
        
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        
        view.todo = todo
        return view
    }
}

protocol IRouterToDo: AnyObject {
    var presenter: IPresenterToDo? { get }
}
