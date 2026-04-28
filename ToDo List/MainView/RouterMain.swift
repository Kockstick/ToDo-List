//
//  RouterMain.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 17.04.2026.
//

import UIKit

class RouterMain: IRouterMain {
    
    weak var presenter: IPresenterMain?
    
    init(presenter: IPresenterMain){
        self.presenter = presenter
    }
    
    static func build() -> UIViewController {
        let view = ViewControllerMain()
        return view
    }
    
    func showTodo(todo: ToDo){
        let todoView = RouterToDo.build(todo: todo)
        if let view = presenter?.viewController as? UIViewController {
            view.navigationController?.pushViewController(todoView, animated: true)
        }
    }
}

protocol IRouterMain {
    var presenter: IPresenterMain? { get }
    
    func showTodo(todo: ToDo)
}
