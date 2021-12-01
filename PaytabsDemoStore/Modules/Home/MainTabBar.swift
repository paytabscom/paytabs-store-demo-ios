//
//  MainTabBar.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 12/09/2021.
//

import UIKit

class MainTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let item1 = HomeVC.make(from: .main, with: HomeVM(dataManager: .init()))
        let item2 = CategoriesVC.make(from: .main, with: CategoriesVM(dataManager: .init()))
        let item3 = FavoritesVC.make(from: .main, with: FavoritesVM(dataManager: .init()))
        let item4 = ProfileVC.make(from: .main, with: ProfileVM(dataManager: .init()))
        
        let icon1 = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let icon2 = UITabBarItem(title: "Categories", image: UIImage(systemName: "square.grid.2x2"), selectedImage: UIImage(systemName: "square.grid.2x2.fill"))
        let icon3 = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        let icon4 = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
        item3.tabBarItem = icon3
        item3.reloadInputViews()
        item4.tabBarItem = icon4
        
        let homeNav = UINavigationController(rootViewController: item1)
        homeNav.navigationBar.largeContentTitle = "Home"
        homeNav.navigationBar.prefersLargeTitles = true
        
        let CategoriesNav = UINavigationController(rootViewController: item2)
        homeNav.navigationBar.largeContentTitle = "Categories"
        homeNav.navigationBar.prefersLargeTitles = true
        
        let FavoritesNav = UINavigationController(rootViewController: item3)
        homeNav.navigationBar.largeContentTitle = "Favorites"
        homeNav.navigationBar.prefersLargeTitles = true
        
        let ProfileNav = UINavigationController(rootViewController: item4)
        homeNav.navigationBar.largeContentTitle = "Profile"
        homeNav.navigationBar.prefersLargeTitles = true
        
        
        let controllers = [homeNav, CategoriesNav ,FavoritesNav , ProfileNav]
        self.viewControllers = controllers
    }
}
//Delegate methods
extension MainTabBar:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false // Make sure you want this as false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.25, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
}

extension MainTabBar {

}

