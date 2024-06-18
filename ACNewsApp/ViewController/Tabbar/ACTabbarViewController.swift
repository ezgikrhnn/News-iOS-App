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
        let newsViewModel = ACNewsViewViewModel()
        let newsPageVC =  ACNewsViewController(viewModel: newsViewModel )
        let categoriesPageVC = CategorySelectionViewController()
        let favsPageVC = ACFavsViewController()
        let settingsPageVC = ACSettingsViewController()
        
        newsPageVC.title = "News"
        categoriesPageVC.title = "Categories"
        favsPageVC.title = "Favs"
        settingsPageVC.title = "Settings"
        
        let nav1 = UINavigationController(rootViewController: newsPageVC)
        let nav2 = UINavigationController(rootViewController: categoriesPageVC)
        let nav3 = UINavigationController(rootViewController: favsPageVC)
        let nav4 = UINavigationController(rootViewController: settingsPageVC)
        
        nav1.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "house.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "circle.grid.2x2"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Favs", image: UIImage(systemName: "heart.fill"), tag: 1)
        
        nav4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        
        for nav in [nav1, nav2, nav3] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        //setViewController = tab bar'ın içeriklerini yönetmek için kullanılır.
        setViewControllers(
            [nav1, nav2, nav3, nav4],
            animated: true)
    }
    private func customizeTabBar() {
            if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = .systemBackground  // Sabit arka plan rengi

                tabBar.standardAppearance = appearance
                tabBar.scrollEdgeAppearance = appearance
            } else {
                tabBar.barTintColor = .systemBackground
            }

            tabBar.tintColor = UIColor(named: "LightRed")
            //tabBar.unselectedItemTintColor = UIColor(named: "LightRed")
            tabBar.layer.masksToBounds = true
        }
}
