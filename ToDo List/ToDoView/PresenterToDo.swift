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
    var completion: ((_ todo: ToDoEntity?) -> Void)?
    
    init(view: IViewControllerToDo){
        viewController = view
        
    }
    
    func save(_ todo: ToDoEntity){
        completion?(todo)
    }
}

protocol IPresenterToDo: AnyObject {
    var viewController: IViewControllerToDo? { get }
    var interactor: IInteractorToDo! { get }
    var router: IRouterToDo! { get }
    var completion: ((_ todo: ToDoEntity?) -> Void)? { get set }
    
    func save(_ todo: ToDoEntity)
}
