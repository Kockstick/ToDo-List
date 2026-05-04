//
//  ViewControllerMain+Search.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 04.05.2026.
//

import Foundation
import UIKit

extension ViewControllerMain: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        do{
            if let text = searchController.searchBar.text, !text.isEmpty {
                fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", text)
            } else {
                fetchRequest.predicate = nil
            }
            
            try fetchedResultsController.performFetch()
            tabView.reloadData()
        } catch {
            print("Failed search: \(error.localizedDescription)")
        }
    }
}
