import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        // 유저 디폴트 값에 따라서 초기값 분기 처리
//        let navRootVc = UINavigationController(rootViewController: LoginViewController())
        
//        let navRootVc = UINavigationController(rootViewController: TodoListViewController())
//        let navRootVc = UINavigationController(rootViewController: WishListViewController())
        
        window?.rootViewController = WishListViewController()
        window?.makeKeyAndVisible()
    }
    
    func changeRootVC(_ vc: UIViewController ) {
        guard let window = self.window else { return }
        
        window.rootViewController = vc
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve) { }
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

