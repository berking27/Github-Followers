//
//  GFAlertsContainerView.swift
//  TakeHomeProject
//
//  Created by Berkin Koca on 29.02.2024.
//

import UIKit

class GFAlertsContainerView: UIView {
     
     override init(frame: CGRect) {
          super.init(frame: frame)
          configure()
          
     }
     
     required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
     }
     
     private func configure() {
          backgroundColor = .systemBackground
          layer.cornerRadius = 16
          layer.borderWidth = 2
          layer.borderColor = UIColor.white.cgColor
          translatesAutoresizingMaskIntoConstraints = false
          
     }
     
}