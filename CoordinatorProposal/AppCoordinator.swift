//
//  AppCoordinator.swift
//  CoordinatorProposal
//
//  Created by antony.alkmim on 26/06/21.
//

import UIKit

enum AppRoute: Route {
    case start
    case auth
    case home
}

enum AppResult: CoordinatorResult {}

class AppCoordinator: Coordinator<AppRoute, AppResult> {

    let window = UIWindow()

    init() {
        window.makeKeyAndVisible()
        super.init(rootViewController: UIViewController())
    }

    override func executeTransition(to route: AppRoute) {
        switch route {
        case .start:
            // if user.isLoggedIn { executeTransition(to: .home) } else { executeTransition(to: .auth) }
            executeTransition(to: .auth)

        case .auth:
            let loginCoordinator = LoginCoordinator { [weak self] loginResult in
                switch loginResult {
                case .userLogged: self?.executeTransition(to: .home)
                case .failed: break
                }

                print("React to login result: \(loginResult)")
            }

            loginCoordinator.executeTransition(to: .username)
            window.rootViewController = loginCoordinator

        case .home:
            let homeController = UIViewController()
            homeController.view.backgroundColor = .systemBlue
            window.rootViewController = homeController
        }
    }


}
