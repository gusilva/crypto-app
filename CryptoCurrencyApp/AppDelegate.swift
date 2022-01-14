import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
    
    let navigationController = UINavigationController(rootViewController: CoinsListViewController())
    window?.rootViewController = navigationController
    
    configureNavigationBar()
    
    return true
  }
  
  func configureNavigationBar() {
    UINavigationBar.appearance().tintColor = .label
  }


}

