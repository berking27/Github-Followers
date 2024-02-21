//
//  UserInfoVC.swift
//  TakeHomeProject
//
//  Created by Berkin KOCA on 21.02.2024.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
