//
//  LoginCoordinator.swift
//  CoordinatorProposal
//
//  Created by antony.alkmim on 26/06/21.
//

import UIKit

enum LoginRoute: Route {
    case username
    case password
    case signup
}

enum LoginResult: CoordinatorResult {
    case userLogged
    case failed
}

final class LoginCoordinator: Coordinator<LoginRoute, LoginResult> {

    let navigation = UINavigationController()

    init(_ didFinish: ((LoginResult) -> Void)? = nil) {
        super.init(rootViewController: navigation, didFinish)
    }

    override func executeTransition(to route: LoginRoute) {
        switch route {
        case .username:
            let controller = UsernameViewController()
            controller.didTapContinue = { [weak self] in self?.executeTransition(to: .password) }
            controller.didTapCancel = { [weak self] in self?.didFinish?(.failed) }
            controller.didTapSignup = { [weak self] in self?.executeTransition(to: .signup) }

            navigation.setViewControllers([controller], animated: true)

        case .password:
            let controller = PasswordViewController()
            controller.didTapContinue = { [weak self] in
                self?.didFinish?(.userLogged)
                self?.navigation.popToRootViewController(animated: true)
            }
            navigation.pushViewController(controller, animated: true)

        case .signup:
            let signupCoordinator = SignupCoordinator { [weak self] in
                self?.handleSignupResult($0)
            }
            signupCoordinator.executeTransition(to: .username)
            navigation.present(signupCoordinator, animated: true, completion: nil)
        }
    }

    private func handleSignupResult(_ result: SignupResult) {
        switch result {
        case .cancelled:
            navigation.presentedViewController?.dismiss(animated: true, completion: nil)

        case .authenticated:
            navigation.presentedViewController?.dismiss(animated: true, completion: nil)
            let alert = UIAlertController(title: "Yahooo!!", message: "User logged in", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
}
