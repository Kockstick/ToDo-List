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
    
    init(view: IViewControllerToDo){
        viewController = view
        interactor = InteractorToDo(presenter: self)
        router = RouterToDo(presenter: self)
    }
    
    func save(_ todo: ToDoEntity){
        interactor.save(todo: todo)
    }
}

protocol IPresenterToDo: AnyObject {
    var viewController: IViewControllerToDo? { get }
    var interactor: IInteractorToDo! { get }
    var router: IRouterToDo! { get }
    
    func save(_ todo: ToDoEntity)
}
