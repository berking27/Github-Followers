//
//  GFTitleLabel.swift
//  TakeHomeProject
//
//  Created by Berkin KOCA on 13.02.2024.
//

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     
     ///Since it is conveinence initializers instead of super.init it should be self.init
     ///Conveinence initilazer will call normal initializers. So that we don't need configure in this initializers
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        //configure()
         ///Since it's conveience initializer Don't need this line of code
    }

    
    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
