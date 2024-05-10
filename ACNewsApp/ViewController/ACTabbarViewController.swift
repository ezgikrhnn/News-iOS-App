//
//  ACTabbarViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import UIKit

class ACTabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabs()
        customizeTabBar()
        self.tabBar.itemPositioning = .fill
    }
    
    private func setUpTabs(){
        let newsPageVC =  ACNewsViewController()
        let favsPageVC = ACFavsViewController()
        let settingsPageVC = ACSettingsViewController()
        
        newsPageVC.title = "News"
        favsPageVC.title = "Favs"
        settingsPageVC.title = "Settings"
        
        let nav1 = UINavigationController(rootViewController: newsPageVC)
        let nav2 = UINavigationController(rootViewController: favsPageVC)
        let nav3 = UINavigationController(rootViewController: settingsPageVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Favs", image: UIImage(systemName: "heart.fill"), tag: 1)
        
        nav3.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        
        for nav in [nav1, nav2, nav3] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        //setViewController = tab bar'ın içeriklerini yönetmek için kullanılır.
        setViewControllers(
            [nav1, nav2, nav3],
            animated: true)
    }
    
    private func customizeTabBar() {
        // Tab Bar Background
        tabBar.barTintColor = .black
        tabBar.tintColor = UIColor(named: "Light0Red")
        tabBar.unselectedItemTintColor = UIColor(named: "LightRed")
        tabBar.layer.masksToBounds = true
        
    }

}
