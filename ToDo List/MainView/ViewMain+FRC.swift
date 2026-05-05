//
//  VCMain+FRV.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 04.05.2026.
//

import Foundation
import CoreData

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
