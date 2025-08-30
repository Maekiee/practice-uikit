import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let navRootVc = UINavigationController(rootViewController: LoginViewController())
//        let navRootVc = UINavigationController(rootViewController: CreateProfileViewController())
//        let navRootVc = UINavigationController(rootViewController: ProfileImageSettingViewController())
//        let navRootVc = UINavigationController(rootViewController: TodoListViewController())
        window?.rootViewController = navRootVc
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

