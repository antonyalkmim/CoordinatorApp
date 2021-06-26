//
//  SignupCoordinator.swift
//  CoordinatorProposal
//
//  Created by antony.alkmim on 26/06/21.
//

import UIKit

enum SignupRoute: Route {
    case username
    case password
}

enum SignupResult: CoordinatorResult {
    case authenticated
    case cancelled
}

final class SignupCoordinator: Coordinator<SignupRoute, SignupResult> {

    let navigation = UINavigationController()

    init(_ didFinish: DidFinishCallback? = nil) {
        super.init(rootViewController: navigation, didFinish)
    }

    override func executeTransition(to route: SignupRoute) {
        switch route {
        case .username:
            let controller = UsernameViewController()
            controller.didTapContinue = { [weak self] in self?.executeTransition(to: .password) }
            controller.didTapCancel = { [weak self] in self?.didFinish?(.cancelled) }
            navigation.setViewControllers([controller], animated: true)

        case .password:
            let controller = PasswordViewController()
            controller.didTapContinue = { [weak self] in self?.didFinish?(.authenticated) }
            navigation.pushViewController(controller, animated: true)
        }
    }
}

