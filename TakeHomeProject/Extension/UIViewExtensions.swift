//
//  UIViewExtensions.swift
//  TakeHomeProject
//
//  Created by Berkin KOCA on 13.02.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}

