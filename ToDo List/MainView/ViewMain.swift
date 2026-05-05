//
//  ViewControllerMain.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 28.04.2026.
//

import UIKit
import CoreData

class ViewMain: UIViewController, IViewMain {
    
    var presenter: IPresenterMain!
    var fetchedResultsController: NSFetchedResultsController<ToDoEntity>!
    var fetchRequest: NSFetchRequest<ToDoEntity>!
    
    internal let identifier = "ToDoCells"
    internal let haptic = UINotificationFeedbackGenerator()
    
    internal let tabView = UITableView()
    internal let footerView = UIFooterView()
    
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
            fetchRequest = NSFetchRequest<ToDoEntity>()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
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
        searchController.searchResultsUpdater = self
        
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

extension ViewMain: IFooterViewDelegate{
    func newTodoDidTap() {
        presenter?.createTodo()
    }
}

//MARK: - VIPER protocol

protocol IViewMain: AnyObject {
    var presenter: IPresenterMain! { get set }
}
