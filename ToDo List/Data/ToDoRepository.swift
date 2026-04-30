//
//  ToDoRepository.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 28.04.2026.
//

import CoreData
import Network

class ToDoRepository: IToDoRepository {
    static var shared: IToDoRepository = ToDoRepository()
    var delegate: ToDoRepositoryDelegate!
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    private(set) var loading = false {
        didSet{
            print("Loading: \(loading)")
            delegate?.onLoadStateChange(loading)
        }
    }
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.preload()
            }
        }
        monitor.start(queue: queue)
    }
    
    func preload() {
        guard !loading else { return }
        print("Try preload data from API")
        Task{
            do {
                loading = true
                defer { loading = false }
                if let data = try await DataPreloader.shared.preloadDataIfNeeded() {
                    for todo in data {
                        addToDo(todo: todo)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func addToDo(todo: ToDo) {
        CoreDataStack.shared.viewContext.performAndWait {
            let context = CoreDataStack.shared.viewContext

            let entity = ToDoEntity(context: context)
            entity.id = todo.id
            entity.title = todo.title
            entity.todo = todo.todo
            entity.date = todo.date
            entity.userId = todo.userId
            entity.completed = false

            do {
                try context.save()
            } catch {
                print("Save error:", error)
            }
        }
    }
}

protocol IToDoRepository: AnyObject {
    var loading: Bool { get }
    var delegate: ToDoRepositoryDelegate! { get set }
    func preload()
}

protocol ToDoRepositoryDelegate: AnyObject {
    func onLoadStateChange(_ loading: Bool)
}
