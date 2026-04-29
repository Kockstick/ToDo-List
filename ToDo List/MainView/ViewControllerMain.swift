//
//  ViewControllerMain.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 28.04.2026.
//

import UIKit
import CoreData

class ViewControllerMain: UIViewController, IViewControllerMain, NSFetchedResultsControllerDelegate {
    
    var presenter: IPresenterMain!
    
    private let identifier = "ToDoCells"
    private let haptic = UINotificationFeedbackGenerator()
    
    var fetchedResultsController: NSFetchedResultsController<ToDoEntity>! = nil
    private var todoList: [ToDo]{
        get {
            return presenter.todos
        }
    }
    
    private let tabView = UITableView()
    private let footerView = UIFooterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let fetchRequest = NSFetchRequest<ToDoEntity>()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
            fetchRequest.entity = NSEntityDescription.entity(forEntityName: "ToDoEntity", in: CoreDataStack.shared.viewContext)!
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            try fetchedResultsController.performFetch()
        } catch {
            print("Error performing fetch: \(error)")
        }
        
        haptic.prepare()
        presenter = PresenterMain(view: self)
        
        confTitle()
        confFooterView()
        confTableView()
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
        //navigationItem.largeTitleDisplayMode = .always
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
        
        NSLayoutConstraint.activate([
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.widthAnchor.constraint(equalToConstant: view.frame.width),
            footerView.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    func refreshTableView(){
        DispatchQueue.main.async { [weak self] in
            self?.tabView.reloadData()
        }
    }
}

//MARK: - Delegate

extension ViewControllerMain: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ToDoCell else{
            return
        }
        
        presenter.didSelectTodo(index: indexPath.row)
        cell.setChecked(todoList[indexPath.row].completed)
        haptic.notificationOccurred(.success)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard let todo = tableView.cellForRow(at: indexPath) as? ToDoCell else{
            return nil
        }
        
        let vc = UIViewController()
        let todoSelected = ToDoSelectedView(size: CGSize(width: todo.frame.width, height: todo.frame.height))
        todoSelected.configure(todo: todoList[indexPath.row])
        
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
            
            let index = indexPath.row
            let edit = UIAction(title: "Редактировать", image: .edit.withTintColor(.white)) { [weak self] _ in
                self?.presenter.editTodo(index)
            }
            
            let send = UIAction(title: "Поделиться", image: .export.withTintColor(.white)) { _ in
            }
            
            let delete = UIAction(title: "Удалить", image: .trash, attributes: .destructive) { _ in
            }
            
            return UIMenu(title: "", children: [edit, send, delete])
        })
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
    func refreshTableView()
}
