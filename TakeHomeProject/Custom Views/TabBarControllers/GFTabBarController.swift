//
//  GFTabBarController.swift
//  TakeHomeProject
//
//  Created by Berkin Koca on 29.02.2024.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

         /// To make TabBar Transparent
         if #available(iOS 15.0, *) {
              UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
         }
         UITabBar.appearance().tintColor = .systemGreen
         
         viewControllers = [createSearchNC(), createFavoritesListNC()]
    }

     func createSearchNC() -> UINavigationController {
         let searchVC = SearchVC()
         searchVC.title = "Search"
         searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
         
         return UINavigationController(rootViewController: searchVC)
     }
     
     func createFavoritesListNC() -> UINavigationController {
         let favoritesListVC = FavoritesListVC()
         favoritesListVC.title = "Favorite List"
         favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
         
         return UINavigationController(rootViewController: favoritesListVC)
     }
}
