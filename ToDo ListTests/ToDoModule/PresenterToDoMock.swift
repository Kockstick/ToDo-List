//
//  PresenterToDoMock.swift
//  ToDo List
//
//  Created by admin on 06.05.2026.
//

@testable import ToDo_List

class PresenterToDoMock: IPresenterToDo{
    var viewController: IViewToDo?
    
    var interactor: IInteractorToDo!
    
    var router: IRouterToDo!
    
    var completion: ((ToDo_List.ToDoDTO?) -> Void)?
    
    public var didSave = false
    public var didCreate = false
    public var title = ""
    public var todo = ""
    
    func save(title: String, todo: String) {
        self.title = title
        self.todo = todo
        didSave = true
    }
    
    func createTodo(title: String, todo: String) {
        self.title = title
        self.todo = todo
        didCreate = true
    }
    
    
}
