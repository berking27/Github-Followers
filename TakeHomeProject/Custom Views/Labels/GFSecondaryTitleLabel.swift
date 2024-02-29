//
//  GFSecondaryTitleLabel.swift
//  TakeHomeProject
//
//  Created by Berkin KOCA on 23.02.2024.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
     ///Since it is conveinence initializers instead of super.init it should be self.init
     ///Conveinence initilazer will call normal initializers. So that we don't need configure in this initializers
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }

    private func configure() {
        textColor = .secondaryLabel
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
