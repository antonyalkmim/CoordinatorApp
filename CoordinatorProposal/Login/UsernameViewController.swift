//
//  LoginViewController.swift
//  CoordinatorProposal
//
//  Created by antony.alkmim on 26/06/21.
//

import UIKit

class UsernameViewController: UIViewController {

    var didTapContinue: (() -> Void)?
    var didTapCancel: (() -> Void)?
    var didTapSignup: (() -> Void)?

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Fill your username"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Signup", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Username"
        setupViews()
    }

    private func setupViews() {
        [label, continueButton, cancelButton, signupButton].forEach(view.addSubview)

        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        continueButton.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        signupButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        cancelButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        // style
        view.backgroundColor = .systemGreen

        // actions
        continueButton.addTarget(self, action: #selector(_didTapContinue), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(_didTapSignup), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(_didTapCancel), for: .touchUpInside)

    }

    @objc private func _didTapContinue() {
        didTapContinue?()
    }

    @objc private func _didTapCancel() {
        didTapCancel?()
    }

    @objc private func _didTapSignup() {
        didTapSignup?()
    }

}
