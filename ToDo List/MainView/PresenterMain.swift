//
//  PresenterMain.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 17.04.2026.
//

class PresenterMain: IPresenterMain{
    
    weak var viewController: IViewControllerMain?
    var interactor: IInteractorMain!
    var router: IRouterMain!
    
    var todoList: [ToDo] {
        get {
            return interactor.todos
        }
    }
    
    init(view: IViewControllerMain){
        viewController = view
        interactor = InteractorMain(presenter: self)
        router = RouterMain(presenter: self)
    }
    
    func viewDidLoad() {
        
    }
    
    func didSelectTodo(_ todo: ToDo) {
        
    }
    
    func editTodo(_ index: Int) {
        router.showTodo(todo: interactor.todos[index])
    }
    
    func exportTodo(_ todo: ToDo) {
        
    }
    
    func deleteTodo(_ todo: ToDo) {
        
    }
    
    func setCompletion(index: Int, value: Bool){
        interactor.setCompletion(index: index, value: value)
    }
    
    func refreshTableView() {
        viewController?.refreshTableView()
    }
}

protocol IPresenterMain: AnyObject {
    var viewController: IViewControllerMain? { get }
    var interactor: IInteractorMain! { get }
    var router: IRouterMain! { get }
    
    var todoList: [ToDo] { get }
    
    func viewDidLoad()
    func didSelectTodo(_ todo: ToDo)
    func editTodo(_ index: Int)
    func exportTodo(_ todo: ToDo)
    func deleteTodo(_ todo: ToDo)
    func setCompletion(index: Int, value: Bool)
    func refreshTableView()
}
