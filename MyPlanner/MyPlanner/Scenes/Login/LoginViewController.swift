//
//  LoginViewController.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 29.05.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let loginButton = UIButton(type: .system)
    let titleLabel = UILabel()
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "MyPlanner"
        titleLabel.textAlignment = .center
        titleLabel.font = ThemeFont.bold(ofSize: 36)
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.tintColor = .purple
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
        let padding: CGFloat = 10
        view.addSubview(titleLabel)
        view.addSubview(loginView)
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: -25),
            
            loginView.heightAnchor.constraint(equalToConstant: 100),
            loginView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            
            loginButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 25),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
        ])
    }
    
    @objc func loginAction() {
        let mainScreen = MainViewController()
        mainScreen.modalPresentationStyle = .fullScreen
        present(mainScreen,animated: true)
    }
}
