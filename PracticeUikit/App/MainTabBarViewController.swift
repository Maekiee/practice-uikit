import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabBarController()
    }
    
    func createTabBarController() {
        let firstTabVC = UIViewController()
        let secondTabVC = UIViewController()
        let thridTabVc = UIViewController()
        
        let firstTabNav = UINavigationController(rootViewController: firstTabVC)
        
        let secondTabNav = UINavigationController(rootViewController: secondTabVC)
        
        let thridTabNav = UINavigationController(rootViewController: thridTabVc)
        
        firstTabNav.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: ""), selectedImage: UIImage(systemName: ""))
        secondTabNav.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: ""), selectedImage: UIImage(systemName: ""))
        thridTabNav.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: ""), selectedImage: UIImage(systemName: ""))
        
        setViewControllers([firstTabNav, secondTabNav, thridTabNav], animated: false)
    }
}
