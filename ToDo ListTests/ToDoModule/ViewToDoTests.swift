//
//  ViewToDoTests.swift
//  ToDo List
//
//  Created by admin on 06.05.2026.
//

@testable import ToDo_List
import XCTest

class ViewToDoTests: XCTestCase {
    func testCreateToDo_Success(){
        let view = ViewToDo()
        let presenter = PresenterToDoMock()
        view.presenter = presenter
        
        view.todo = nil
        view.loadViewIfNeeded()
        view.viewWillDisappear(false)
        
        XCTAssertEqual(presenter.didCreate, true)
        XCTAssertEqual(presenter.didSave, false)
    }
    
    func testEditToDo_Success(){
        let view = ViewToDo()
        let presenter = PresenterToDoMock()
        view.presenter = presenter
        
        var context = CoreDataStack.shared.viewContext
        let todo = ToDoEntity(context: context)
        todo.title = "Test"
        todo.todo = "Test"
        view.todo = todo
        
        view.titleField.text = "Editied"
        view.textView.text = "Editied"
        
        view.loadViewIfNeeded()
        view.viewWillDisappear(false)
        
        XCTAssertEqual(presenter.didCreate, false)
        XCTAssertEqual(presenter.didSave, true)
        XCTAssertNotEqual(presenter.title, "Test")
        XCTAssertNotEqual(presenter.todo, "Test")
    }
    
    func testNoEditToDo_Success(){
        let view = ViewToDo()
        let presenter = PresenterToDoMock()
        view.presenter = presenter
        
        var context = CoreDataStack.shared.viewContext
        let todo = ToDoEntity(context: context)
        todo.title = "Test"
        todo.todo = "Test"
        view.todo = todo
        
        view.loadViewIfNeeded()
        view.viewWillDisappear(false)
        
        XCTAssertEqual(presenter.didCreate, false)
        XCTAssertEqual(presenter.didSave, false)
    }
}
