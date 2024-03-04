//
//  UITableView+Extension.swift
//  TakeHomeProject
//
//  Created by Berkin KOCA on 4.03.2024.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
}
