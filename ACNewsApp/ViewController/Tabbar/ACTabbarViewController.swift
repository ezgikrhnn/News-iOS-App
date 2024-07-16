//
//  ACTabbarViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ACTabbarViewController: UITabBarController {
    
    private var userModel: UserModel?
       
       init(userModel: UserModel?) {
           self.userModel = userModel
           super.init(nibName: nil, bundle: nil)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabs()
        customizeTabBar()
        self.tabBar.itemPositioning = .fill
    }
    
    private func setUpTabs(){
        let newsViewModel = ACNewsViewViewModel()
        let discoverViewModel = DiscoverViewViewModel()
        
        let defaultCategory = String()
        
        let newsPageVC =  ACNewsViewController(viewModel: newsViewModel )
        let discoverPageVC = DiscoverViewController(viewModel: discoverViewModel, category: defaultCategory)
        let savePageVC = SaveViewController()
        
       /* // LogInViewModel oluşturma
        let auth = Auth.auth()
        let firestore = Firestore.firestore()
        let logInViewModel = LogInViewModel(auth: auth, firestore: firestore)
        let profilePageVC = LogInViewController(viewModel: logInViewModel) // ViewModel ile ViewController'ı initialize edin
           */
        
        // Kullanıcı bilgilerini Firebase'den al
        guard let currentUser = Auth.auth().currentUser else {
            // Kullanıcı oturum açmamışsa veya hata varsa, gerekli işlemleri yapın
            print("No user is logged in")
            return
        }
        
        // UserModel nesnesini oluşturun
        let usermodel = UserModel(name: currentUser.displayName ?? "",
                                  surname: "", // Soyadı Firebase'den gelmiyorsa sabit bir değer ya da boş bırakabilirsiniz
                                  email: currentUser.email ?? "",
                                  uid: currentUser.uid)
        
        let profilePageVC = HomeViewController(userModel: usermodel, authService: Auth.auth())
        
        newsPageVC.title = "News"
        discoverPageVC.title = "Discover"
        savePageVC.title = "Favs"
        profilePageVC.title = "Profile"
        
        let nav1 = UINavigationController(rootViewController: newsPageVC)
        let nav2 = UINavigationController(rootViewController: discoverPageVC)

        let nav3 = UINavigationController(rootViewController: savePageVC)
        let nav4 = UINavigationController(rootViewController: profilePageVC)
        
        nav1.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "house.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "safari"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Save", image: UIImage(systemName: "bookmark.fill"), tag: 1)
        nav4.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        
        
        //setViewController = tab bar'ın içeriklerini yönetmek için kullanılır.
        setViewControllers(
            [nav1,nav2, nav3, nav4],
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
