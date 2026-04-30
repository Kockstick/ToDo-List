//
//  ViewControllerToDo.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 17.04.2026.
//

import UIKit

class ViewControllerToDo: UIViewController, IViewControllerToDo {
    
    var todo: ToDoEntity! = nil
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        scrollView.keyboardDismissMode = .interactive
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var dateView: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.text = todo.date?.formattedDate ?? Date.now.formattedDate
        return label
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = todo.todo
        textView.font = .systemFont(ofSize: 18)
        textView.textContainer.lineFragmentPadding = 0
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = todo.title ?? "Untitled"
        navigationItem.backButtonTitle = "Назад"
        navigationController?.navigationBar.tintColor = .yellow
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(dateView)
        scrollView.addSubview(textView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            dateView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            dateView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            textView.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 10),
            textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40),
            textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            textView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -32),
            textView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor, multiplier: 0.8),
        ])
    }
}

extension ViewControllerToDo: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

protocol IViewControllerToDo: AnyObject {
    
}
