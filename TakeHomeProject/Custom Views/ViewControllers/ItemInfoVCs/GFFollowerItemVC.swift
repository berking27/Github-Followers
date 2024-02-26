//
//  GFFollowerItemVC.swift
//  TakeHomeProject
//
//  Created by Berkin KOCA on 26.02.2024.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        
        actionButton.set(backgroundColor: .systemGreen, title: "Github Profile")
    }
}
