//
//  PresenterToDO.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 17.04.2026.
//

class PresenterToDo: IPresenterToDo{
    
    weak var viewController: IViewControllerToDo?
    var interactor: IInteractorToDo!
    var router: IRouterToDo!
    var completion: ((_ todo: ToDo?) -> Void)?
    
    init(view: IViewControllerToDo){
        viewController = view
        
    }
    
    func save(title: String, todo: String){
        let todo = ToDo(title: title, todo: todo)
        completion?(todo)
    }
    
    func createTodo(title: String, todo: String) {
        let todo = ToDo(title: title, todo: todo)
        completion?(todo)
    }
}

protocol IPresenterToDo: AnyObject {
    var viewController: IViewControllerToDo? { get }
    var interactor: IInteractorToDo! { get }
    var router: IRouterToDo! { get }
    var completion: ((_ todo: ToDo?) -> Void)? { get set }
    
    func save(title: String, todo: String)
    func createTodo(title: String, todo: String)
}
