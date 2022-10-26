//
//  ViewController.swift
//  3_CollectionViewPractice
//
//  Created by Vicki Yang on 2022/10/24.
//

import UIKit

class ViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController.init(nibName: "HomeViewController", bundle: nil)
        let homeNavigation = UINavigationController(rootViewController: homeVC)
        homeNavigation.tabBarItem.image = UIImage(systemName: "house")
        homeNavigation.tabBarItem.title = "Home"
        
        let favoritesVC = FavoritesViewController()
        let favoritesNavigation = UINavigationController(rootViewController: favoritesVC)
        favoritesNavigation.tabBarItem.image = UIImage(systemName: "star")
        favoritesNavigation.tabBarItem.title = "Favorites"
        
        let personalVC = PersonalViewController()
        let personalNavigation = UINavigationController(rootViewController: personalVC)
        personalNavigation.tabBarItem.image = UIImage(systemName: "person")
        personalNavigation.tabBarItem.title = "Personal"
        
        viewControllers = [homeNavigation, favoritesNavigation, personalNavigation]
    }
}

class FavoritesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        self.view.backgroundColor = .systemPink
    }
}

class PersonalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "個人頁面"
        self.view.backgroundColor = .yellow
    }
}
