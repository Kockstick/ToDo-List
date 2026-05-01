//
//  PresenterMain.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 17.04.2026.
//

class PresenterMain: IPresenterMain, ToDoRepositoryDelegate{
    
    weak var viewController: IViewControllerMain?
    var interactor: IInteractorMain!
    var router: IRouterMain!
    
    init(view: IViewControllerMain){
        viewController = view
    }
    
    func viewDidLoad() {
        
    }
    
    func didSelectTodo(todo: ToDoEntity) {
        interactor.setCompletion(todo: todo)
    }
    
    func editTodo(_ todoEntity: ToDoEntity?) {
        if let todo = todoEntity {
            router.editTodo(todo: todo)
        }
    }
    
    func exportTodo(_ todo: ToDo) {
        
    }
    
    func deleteTodo(_ todoEntity: ToDoEntity?) {
        if let todoEntity = todoEntity {
            interactor.deleteTodo(todo: todoEntity)
        }
    }
    
    func createTodo() {
        router.createTodo()
    }
    
    func onLoadStateChange(_ loading: Bool) {
        
    }
}

protocol IPresenterMain: AnyObject {
    var viewController: IViewControllerMain? { get }
    var interactor: IInteractorMain! { get }
    var router: IRouterMain! { get }
    
    func viewDidLoad()
    func didSelectTodo(todo: ToDoEntity)
    func editTodo(_ todoEntity: ToDoEntity?)
    func exportTodo(_ todo: ToDo)
    func deleteTodo(_ todoEntity: ToDoEntity?)
    func createTodo()
}
