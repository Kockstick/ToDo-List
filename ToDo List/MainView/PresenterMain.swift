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
    
    var todos: [ToDo] {
        get{
            interactor.repository.todos
        }
    }
    
    init(view: IViewControllerMain){
        viewController = view
        interactor = InteractorMain(presenter: self)
        router = RouterMain(presenter: self)
    }
    
    func viewDidLoad() {
        
    }
    
    func didSelectTodo(index: Int) {
        interactor.setCompletion(index: index)
    }
    
    func editTodo(_ index: Int) {
        router.showTodo(todo: todos[index])
    }
    
    func exportTodo(_ todo: ToDo) {
        
    }
    
    func deleteTodo(_ todo: ToDo) {
        
    }
    
    func refreshTableView() {
        viewController?.refreshTableView()
    }
    
    func toDoDidUpdate(_ todos: [ToDo]) {
        refreshTableView()
    }
    
    func onLoadStateChange(_ loading: Bool) {
        
    }
}

protocol IPresenterMain: AnyObject {
    var viewController: IViewControllerMain? { get }
    var interactor: IInteractorMain! { get }
    var router: IRouterMain! { get }
    var todos: [ToDo] { get }
    
    func viewDidLoad()
    func didSelectTodo(index: Int)
    func editTodo(_ index: Int)
    func exportTodo(_ todo: ToDo)
    func deleteTodo(_ todo: ToDo)
    func refreshTableView()
}
