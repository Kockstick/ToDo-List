//
//  ToDoRepository.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 28.04.2026.
//

class ToDoRepository: IToDoRepository {
    var delegate: ToDoRepositoryDelegate?
    
    static var shared = ToDoRepository()
    
    private(set) var loading = false {
        didSet{
            delegate?.onLoadStateChange(loading)
        }
    }
    
    var todos: [ToDo] = []
    
    private init(){
        preload()
    }
    
    private func preload() {
        Task{
            do {
                loading = true
                defer { loading = false }
                if let data = try await DataPreloader.shared.preloadDataIfNeeded() {
                    todos += data
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

protocol IToDoRepository {
    var loading: Bool { get }
    var todos: [ToDo] { get set }
    var delegate: ToDoRepositoryDelegate? { get set }
}

protocol ToDoRepositoryDelegate: AnyObject {
    func toDoDidUpdate(_ todos: [ToDo])
    func onLoadStateChange(_ loading: Bool)
}
