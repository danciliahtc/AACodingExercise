//
//  LoginViewController.swift
//  AACodingExercise
//
//  Created by Dancilia Harmon   on 1/17/25.
//


//
//  ViewController.swift
//  jobBoardTableView
//
//  Created by Dancilia Harmon   on 12/26/24.
//

import UIKit

class LoginViewController: UIViewController {
    private let userNameTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let passwordTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(userNameTF)
        view.addSubview(passwordTF)
        view.addSubview(loginButton)
        
        userNameTF.translatesAutoresizingMaskIntoConstraints = false
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userNameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameTF.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            userNameTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            passwordTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTF.topAnchor.constraint(equalTo: userNameTF.bottomAnchor, constant: 20),
            passwordTF.widthAnchor.constraint(equalTo: userNameTF.widthAnchor),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalTo: userNameTF.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func loginButtonTapped() {
        let viewModel = LoginViewModel()
        let result = viewModel.validateCredentials(userName: userNameTF.text, passWord: passwordTF.text)
        
        switch result {
        case .success:
            let searchNetwork = SearchNetwork()
            let searchViewModel = SearchViewModel(searchNetwork: searchNetwork)
            let searchViewController = SearchViewController(viewModel: searchViewModel)
            navigationController?.pushViewController(searchViewController, animated: true)
        case .failure(let message):
            let alert = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
