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
    
    static func build(todo: ToDo) -> UIViewController {
        let view = ViewControllerToDo()
        view.todo = todo
        return view
    }
}

protocol IRouterToDo: AnyObject {
    var presenter: IPresenterToDo? { get }
}
