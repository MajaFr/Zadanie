//
//  SceneDelegate.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?
    var serviceProvider: ServiceProviderProtocol = ServiceProvider()
    
    lazy var navigationController = UINavigationController().then {
        $0.navigationBar.prefersLargeTitles = false
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = AppColors.navBarBackground
        
        $0.navigationBar.tintColor = .white
        $0.navigationBar.standardAppearance = appearance
        $0.navigationBar.compactAppearance = appearance
        $0.navigationBar.scrollEdgeAppearance = appearance
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        
        coordinator = MainCoordinator(navigationController: navigationController, serviceProvider: serviceProvider)
        coordinator?.goToMainView()

    }
}

