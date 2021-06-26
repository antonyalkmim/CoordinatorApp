# Coordinator ViewController based

This is a tiny app to improve navigation flow logic in our iOS apps.

----


You can check the coordinator implementation in [Coordinator.swift](./CoordinatorProposal/Core/Coordinator.swift).

## Why?
- Easy to read and understand the navigation logic.
- Keeps your navigation logic separated from your views, preventing massive view controllers.
- Prevent memory leaks by releasing its child coordinators/controllers automatically
- Lifecycler for our coordinators (`viewDidLoad`, `viewWillAppear`, `viewDidDisappear`, etc)


## Usage

Here is a small example of how to configure your coordinator:

```swift
enum LoginRoute: Route {
    case username
    case password
}

enum LoginResult: CoordinatorResult {
    case authenticated
    case cancelled
}

final class LoginCoordinator: Coordinator<LoginRoute, LoginResult> {

    let navigation = UINavigationController()

    init(_ didFinish: DidFinishCallback? = nil) {
        super.init(rootViewController: navigation, didFinish)
    }

    override func executeTransition(to route: LoginRoute) {
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
```

After configure your coordinator you can present it the same way you usually present any `UIViewController`:
```swift
let loginCoordinator = LoginCoordinator { result in
    // execute something when user authenticated or cancelled login
}
loginCoordinator.executeTransition(to: .username) // ask coordinator to execute transition to some LoginRoute

// setting the coordinator as your window rootViewController
window.rootViewController = loginCoordinator
// or just presenting as another viewController
viewController.present(loginCoordinator, animated: true, completion: nil)
```


## TODO
- [ ] Improve testability
- [ ] Add tests for coordinators
- [ ] Add documentation