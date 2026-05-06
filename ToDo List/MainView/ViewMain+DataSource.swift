//
//  VCMain+DataSource.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 04.05.2026.
//

import Foundation
import UIKit

extension ViewMain: UITableViewDataSource {
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
