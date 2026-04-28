//
//  ToDoSelectedView.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 16.04.2026.
//

import UIKit

class ToDoSelectedView: UIView{
    
    let paddingX = CGFloat(18)
    let paddingY = CGFloat(16)
    
    let titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    let todoView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    let dateView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.layer.cornerRadius = 12
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .todoGray
        
        confView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(size: CGSize){
        let frame = CGRect(origin: .zero, size: size)
        self.init(frame: frame)
    }
    
    private func confView(){
        self.addSubview(titleView)
        self.addSubview(todoView)
        self.addSubview(dateView)
        
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: paddingX),
            titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -paddingX),
            titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: paddingY),
            
            todoView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            todoView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            todoView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: paddingY * 0.5),
            
            dateView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            dateView.topAnchor.constraint(equalTo: todoView.bottomAnchor, constant: paddingY * 0.5),
            dateView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -paddingY),
        ])
    }
    
    func configure(title: String, todo: String, date: String){
        self.titleView.text = title
        self.todoView.text = todo
        self.dateView.text = date
    }
    
    func configure(todo: ToDo?){
        self.configure(title: todo?.title ?? "Untitled", todo: todo?.todo ?? "", date: todo?.date?.formattedDate ?? Date.now.formattedDate)
    }
}
