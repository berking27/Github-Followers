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
     convenience init(color: UIColor, title: String, systemImageName: String) {
          self.init(frame: .zero)
          set(color: color, title: title, systemImageName: systemImageName)
     }
    
    private func configure() {
        //These features are available iOS 15 or greater!
        configuration = .tinted()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    final func set(color: UIColor, title: String, systemImageName: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
        
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
    }
    
}

#Preview {
    GFButton(color: .green, title: "Test Button", systemImageName: "pencil")
}
