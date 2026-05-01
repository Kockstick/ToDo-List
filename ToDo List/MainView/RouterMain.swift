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
        let repository = ToDoRepository.shared
        let view = ViewControllerMain()
        let presenter = PresenterMain(view: view)
        let interactor = InteractorMain(presenter: presenter)
        let router = RouterMain(presenter: presenter)
        
        repository.delegate = presenter
        view.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        interactor.repository = repository
        
        return view
    }
    
    func editTodo(todo: ToDoEntity){
        let todoView = RouterToDo.build(todo) { newTodo in
            guard let newTodo = newTodo else { return }
            
            let context = CoreDataStack.shared.viewContext
            todo.update(from: newTodo)
            
            do{
                try context.save()
            } catch {
                print("Error save todo: \(error.localizedDescription)")
            }
        }
        
        if let view = presenter?.viewController as? UIViewController {
            view.navigationController?.pushViewController(todoView, animated: true)
        }
    }
    
    func createTodo() {
        let todoView = RouterToDo.build(nil) { newTodo in
            guard let newTodo = newTodo else { return }
            
            let context = CoreDataStack.shared.viewContext
            let todo = ToDoEntity(context: context)
            todo.create(from: newTodo)
            
            do{
                try context.save()
            } catch {
                print("Error create todo: \(error.localizedDescription)")
            }
        }
        
        if let view = presenter?.viewController as? UIViewController {
            view.navigationController?.pushViewController(todoView, animated: true)
        }

    }
}

protocol IRouterMain {
    var presenter: IPresenterMain? { get }
    
    func editTodo(todo: ToDoEntity)
    func createTodo()
}
