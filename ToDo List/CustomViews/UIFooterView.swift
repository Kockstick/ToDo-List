//
//  UIFooterView.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 16.04.2026.
//

import UIKit

class UIFooterView: UIView{
    
    var delegate: IFooterViewDelegate?
    
    let labelAmount: UILabel = {
        let label = UILabel()
        label.text = "7"
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelTask: UILabel = {
        let label = UILabel()
        label.text = "Задач"
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(labelAmount)
        stack.addArrangedSubview(labelTask)
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 5
        return stack
    }()
    
    let pencilView: UIImageView =  {
        let image = UIImageView(image: UIImage(systemName: "square.and.pencil"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .yellow
        image.frame.size = CGSize(width: 28, height: 28)
        return image
    }()
    
    lazy var createBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addSubview(pencilView)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .todoGray
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(hStack)
        
        self.addSubview(createBtn)
        
        createBtn.addAction(UIAction { [weak self] _ in
            self?.delegate?.newTodoDidTap()
        }, for: .touchUpInside)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            hStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            createBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            createBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            createBtn.widthAnchor.constraint(equalToConstant: pencilView.frame.width),
            createBtn.heightAnchor.constraint(equalToConstant: pencilView.frame.height),
            
            pencilView.widthAnchor.constraint(equalToConstant: pencilView.frame.width),
            pencilView.heightAnchor.constraint(equalToConstant: pencilView.frame.height),
        ])
    }
    
    func onChangeAmountTodo(_ amount: Int) {
        labelAmount.text = "\(amount)"
    }
}

protocol IFooterViewDelegate: AnyObject {
    func newTodoDidTap()
}
