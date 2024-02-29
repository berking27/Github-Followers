//
//  GFButton.swift
//  TakeHomeProject
//
//  Created by Berkin KOCA on 12.02.2024.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    ///This part will work Whenever storyboard is used
    ///Since Storyboard won't used in this project we write fatalError!
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     ///Since it is conveinence initializers instead of super.init it should be self.init
     ///Conveinence initilazer will call normal initializers. So that we don't need configure in this initializers
     convenience init(backgroundColor: UIColor, title: String) {
          self.init(frame: .zero)
          self.backgroundColor = backgroundColor
          self.setTitle(title, for: .normal)
          
     }
    
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
}

