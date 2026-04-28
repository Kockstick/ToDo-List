//
//  UICheckView.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 15.04.2026.
//

import UIKit

class UICheckView: UIView {
    
    let tick = UIImageView(image: .tick)
    let circle = UIImageView(image: .circle)
    
    init(size: Int){
        let cgSize = CGSize(width: size, height: size)
        let frame = CGRect(origin: .zero, size: cgSize)
        super.init(frame: frame)
        
        circle.frame.size = cgSize
        circle.tintColor = UIColor.gray
        self.addSubview(circle)
        
        tick.tintColor = UIColor.yellow
        tick.isHidden = true
        tick.translatesAutoresizingMaskIntoConstraints = false
        circle.addSubview(tick)
        
        NSLayoutConstraint.activate([
            tick.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tick.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCheck(_ isChecked: Bool){
        if isChecked {
            circle.tintColor = UIColor.yellow
        } else {
            circle.tintColor = UIColor.gray
        }
        tick.isHidden = !isChecked
    }
}
