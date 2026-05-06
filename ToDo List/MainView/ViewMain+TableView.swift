//
//  ViewControllerMain+TableView.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 04.05.2026.
//

import Foundation
import UIKit

extension ViewMain: UITableViewDelegate {
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
