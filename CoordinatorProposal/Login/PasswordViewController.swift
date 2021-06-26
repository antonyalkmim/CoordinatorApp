//
//  PasswordViewController.swift
//  CoordinatorProposal
//
//  Created by antony.alkmim on 26/06/21.
//

import UIKit

class PasswordViewController: UIViewController {

    var didTapContinue: (() -> Void)?

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Fill your Password"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var message: String? {
        didSet {
            label.text = message
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Password"
        setupViews()
    }

    private func setupViews() {
        [label, button].forEach(view.addSubview)

        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        button.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        // style
        view.backgroundColor = .systemGreen

        // actions
        button.addTarget(self, action: #selector(_didTapContinue), for: .touchUpInside)

    }

    @objc private func _didTapContinue() {
        didTapContinue?()
    }

}

