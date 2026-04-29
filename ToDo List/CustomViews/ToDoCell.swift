//
//  TaskCell.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 14.04.2026.
//

import UIKit

class ToDoCell: UITableViewCell {
    
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
    let checkView: UICheckView = {
        let view = UICheckView(size: 26)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        view.layer.opacity = 0.5
        view.frame.size = CGSize(width: contentView.frame.width, height: 1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        confView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func confView(){
        
        contentView.addSubview(checkView)
        contentView.addSubview(titleView)
        contentView.addSubview(todoView)
        contentView.addSubview(dateView)
        contentView.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            checkView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: paddingX),
            checkView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: paddingY),
            checkView.widthAnchor.constraint(equalToConstant: checkView.frame.width),
            checkView.heightAnchor.constraint(equalToConstant: checkView.frame.height),
            
            titleView.leadingAnchor.constraint(equalTo: checkView.trailingAnchor, constant: paddingX * 0.5),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -paddingX),
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: paddingY),
            
            todoView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            todoView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            todoView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: paddingY * 0.5),
            
            dateView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            dateView.topAnchor.constraint(equalTo: todoView.bottomAnchor, constant: paddingY * 0.5),
            dateView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -paddingY),
            
            separatorView.leadingAnchor.constraint(equalTo: checkView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.widthAnchor.constraint(equalToConstant: separatorView.frame.width),
            separatorView.heightAnchor.constraint(equalToConstant: separatorView.frame.height),
        ])
    }
    
    func configure(with todo: ToDo){
        titleView.text = todo.title ?? "Untitled"
        todoView.text = todo.todo
        dateView.text = todo.date?.formattedDate ?? Date.now.formattedDate
        
        setChecked(todo.completed)
    }
    
    func configure(with todo: ToDoEntity){
        titleView.text = todo.title ?? "Untitled"
        todoView.text = todo.todo
        dateView.text = todo.date?.formattedDate ?? Date.now.formattedDate
        
        setChecked(todo.completed)
    }
    
    func setChecked(_ completed: Bool){
        if completed {
            let attributed = NSAttributedString(
                string: titleView.text ?? "",
                attributes: [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue
                ]
            )
            
            titleView.attributedText = attributed
            titleView.textColor = UIColor.gray
            todoView.textColor = UIColor.gray
        } else {
            let attributed = NSAttributedString(
                string: titleView.text ?? "",
            )
            
            titleView.attributedText = attributed
            titleView.textColor = UIColor.white
            todoView.textColor = UIColor.white
        }
        
        checkView.setCheck(completed)
    }
}
