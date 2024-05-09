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
        ChangeOrientation(width: self.tabBar.bounds.width)
        
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
    
    
    override func viewWillTransition(to size: CGSize, with coordinator :UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        removeSeperator()
        ChangeOrientation(width: size.width)
    }
    
    func removeSeperator() {
        if let items = self.tabBar.items {
            for (index, _) in items.enumerated() {
                //We don't want a separator on the left of the first item.
                if index > 0 {
                    if let viewWithTag = tabBar.viewWithTag(index) {
                        //print("index for remove : \(index)")
                        viewWithTag.removeFromSuperview()
                    }
                    else {
                        print("tag not found")
                    }
                }
            }
        }
    }
    
    func ChangeOrientation(width : CGFloat) {
        if let items = self.tabBar.items {
            //Get the height of the tab bar
            let height = self.tabBar.bounds.height
            //Calculate the size of the items
            let numItems = CGFloat(items.count)
            let itemSize = CGSize(
                width: width / numItems,
                height: tabBar.frame.height)
            for (index, _) in items.enumerated() {
                //We don't want a separator on the left of the first item.
                if index > 0 {
                    //Xposition of the item
                    let xPosition = itemSize.width * CGFloat(index)
                    /* Create UI view at the Xposition,
                     with a width of 0.5 and height equal
                     to the tab bar height, and give the
                     view a background color
                     */
                    //print("index : \(index)")
                    let separator = UIView(frame: CGRect(
                        x: xPosition, y: 0, width: 0.8, height: height))
                    separator.tag = index
                    separator.backgroundColor = UIColor(named: "LightRed")
                    tabBar.insertSubview(separator, at: 1)
                }
            }
        }
        
        
    }
}
