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
    
    static func build(_ todo: ToDoEntity?, completion: ((_ todo: ToDoDTO?) -> Void)? = nil) -> UIViewController {
        let view = ViewToDo()
        let presenter = PresenterToDo(view: view)
        let interactor = InteractorToDo(presenter: presenter)
        let router = RouterToDo(presenter: presenter)
        
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        
        presenter.completion = completion
        view.todo = todo
        
        return view
    }
}

protocol IRouterToDo: AnyObject {
    var presenter: IPresenterToDo? { get }
}
