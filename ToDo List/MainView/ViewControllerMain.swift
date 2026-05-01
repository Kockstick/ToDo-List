//
//  ViewControllerMain.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 28.04.2026.
//

import UIKit
import CoreData

class ViewControllerMain: UIViewController, IViewControllerMain {
    
    var presenter: IPresenterMain!
    var fetchedResultsController: NSFetchedResultsController<ToDoEntity>! = nil
    
    private let identifier = "ToDoCells"
    private let haptic = UINotificationFeedbackGenerator()
    
    private let tabView = UITableView()
    private let footerView = UIFooterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        haptic.prepare()
        
        initFRC()
        confTitle()
        confFooterView()
        confTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ToDoRepository.shared.preload()
    }
    
    private func initFRC(){
        do {
            let fetchRequest = NSFetchRequest<ToDoEntity>()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
            fetchRequest.entity = NSEntityDescription.entity(forEntityName: "ToDoEntity", in: CoreDataStack.shared.viewContext)!
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
            try fetchedResultsController.performFetch()
        } catch {
            print("Error performing fetch: \(error)")
        }
    }

    //MARK: - Configure views
    
    private func confTitle(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.searchBarStyle = .minimal
        
        //let textField = searchController.searchBar.searchTextField
        //textField.backgroundColor = .todoGray
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Задачи"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
    }
    
    private func confTableView(){
        view.addSubview(tabView)
        
        tabView.translatesAutoresizingMaskIntoConstraints = false
        tabView.dataSource = self
        tabView.delegate = self
        tabView.register(ToDoCell.self, forCellReuseIdentifier: identifier)
        tabView.rowHeight = UITableView.automaticDimension
        tabView.separatorInset = .zero
        tabView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            tabView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tabView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tabView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
        ])
    }
    
    private func confFooterView(){
        view.addSubview(footerView)
        footerView.onChangeAmountTodo(fetchedResultsController.fetchedObjects?.count ?? 0)
        footerView.delegate = self
        
        NSLayoutConstraint.activate([
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.widthAnchor.constraint(equalToConstant: view.frame.width),
            footerView.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
}

//MARK: - Footer Delegate

extension ViewControllerMain: IFooterViewDelegate{
    func newTodoDidTap() {
        presenter?.createTodo()
    }
}

//MARK: - TableView Delegate

extension ViewControllerMain: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ToDoCell else{
            return
        }
        
        presenter.didSelectTodo(todo: fetchedResultsController.object(at: indexPath))
        cell.setChecked(fetchedResultsController.object(at: indexPath).completed)
        haptic.notificationOccurred(.success)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard let todo = tableView.cellForRow(at: indexPath) as? ToDoCell else{
            return nil
        }
        
        let vc = UIViewController()
        let todoSelected = ToDoSelectedView(size: CGSize(width: todo.frame.width, height: todo.frame.height))
        todoSelected.configure(todo: fetchedResultsController.object(at: indexPath))
        
        vc.preferredContentSize = CGSize(width: todoSelected.frame.width, height: todoSelected.frame.height)
        vc.view.addSubview(todoSelected)
        
        NSLayoutConstraint.activate([
            todoSelected.topAnchor.constraint(equalTo: vc.view.topAnchor),
            todoSelected.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
            todoSelected.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
            todoSelected.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
        ])
        
        let previewProvider: UIContextMenuContentPreviewProvider = { vc }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: previewProvider, actionProvider: { _ in
            
            let edit = UIAction(title: "Редактировать", image: .edit.withTintColor(.white)) { [weak self] _ in
                self?.presenter.editTodo(self?.fetchedResultsController.object(at: indexPath))
            }
            
            let send = UIAction(title: "Поделиться", image: .export.withTintColor(.white)) { _ in
            }
            
            let delete = UIAction(title: "Удалить", image: .trash, attributes: .destructive) { [weak self] _ in
                self?.presenter.deleteTodo(self?.fetchedResultsController.object(at: indexPath))
            }
            
            return UIMenu(title: "", children: [edit, send, delete])
        })
    }
}

//MARK: - FRC

extension ViewControllerMain: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        tabView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tabView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tabView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            if let indexPath = indexPath,
                   let cell = tabView.cellForRow(at: indexPath) as? ToDoCell {
                    let object = fetchedResultsController.object(at: indexPath)
                    cell.configure(with: object)
                }
        case .move:
            tabView.moveRow(at: indexPath!, to: newIndexPath!)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        tabView.endUpdates()
        footerView.onChangeAmountTodo(fetchedResultsController.fetchedObjects?.count ?? 0)
    }
}

//MARK: - Data source

extension ViewControllerMain: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ToDoCell else{
            return UITableViewCell()
        }
        
        let todoEntity = fetchedResultsController.object(at: indexPath)
        
        cell.selectionStyle = .none
        cell.configure(with: todoEntity)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections[section].numberOfObjects
    }
    
}


//MARK: - VIPER protocol

protocol IViewControllerMain: AnyObject {
    var presenter: IPresenterMain! { get set }
}
