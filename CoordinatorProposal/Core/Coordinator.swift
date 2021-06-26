//
//  Coordinator.swift
//  CoordinatorProposal
//
//  Created by antony.alkmim on 26/06/21.
//

import Foundation
import UIKit

protocol Route { }
protocol CoordinatorResult {}

class Coordinator<RouteType: Route, ResultType: CoordinatorResult>: UIViewController {

    typealias DidFinishCallback = (ResultType) -> Void

    var didFinish: ((ResultType) -> Void)? = nil
    var didDismiss: (() -> Void)? = nil

    init(rootViewController: UIViewController, _ didFinish: DidFinishCallback? = nil) {
        self.didFinish = didFinish
        super.init(nibName: nil, bundle: nil)
        setRoot(rootViewController)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setRoot(_ controller: UIViewController) {
        if let currentController = children.last {
            currentController.view.removeFromSuperview()
            currentController.removeFromParent()
        }
        
        addChild(controller)
        view.addSubview(controller.view)
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        controller.didMove(toParent: self)
    }

    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isBeingDismissed || isMovingFromParent {
            didDismiss?()
            didDismiss = nil
        }
    }

    func executeTransition(to route: RouteType) { }
}
