//
//  AppDelegate.swift
//  CoordinatorProposal
//
//  Created by antony.alkmim on 26/06/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        appCoordinator = AppCoordinator()
        appCoordinator?.executeTransition(to: .start)

        return true
    }


}

