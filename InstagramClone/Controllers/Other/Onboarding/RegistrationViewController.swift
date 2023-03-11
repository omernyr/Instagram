//
//  RegistrationViewController.swift
//  InstagramClone
//
//  Created by macbook pro on 7.03.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private let userNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground
        field.isSecureTextEntry = true
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        userNameField.delegate = self
        passwordTextField.delegate = self
        emailField.delegate = self
        view.addSubview(userNameField)
        view.addSubview(passwordTextField)
        view.addSubview(emailField)
        view.addSubview(registerButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userNameField.frame = CGRect(x: 20,
                                     y: view.safeAreaInsets.top + 10,
                                     width: view.width - 40,
                                     height: 52)
        emailField.frame = CGRect(x: 20,
                                  y: passwordTextField.bottom + 10,
                                  width: view.width - 40,
                                  height: 52)
        passwordTextField.frame = CGRect(x: 20,
                                         y: userNameField.bottom + 10,
                                         width: view.width - 40,
                                         height: 52)
        registerButton.frame = CGRect(x: 20,
                                      y: emailField.bottom + 10,
                                      width: view.width - 40,
                                      height: 52)
    }
    
    @objc func didTapRegisterButton() {
        userNameField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        emailField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count >= 4,
              let username = userNameField.text, !username.isEmpty else { return }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
            DispatchQueue.main.async {
                if registered {
                    
                } else {
                    
                }
            }
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordTextField.becomeFirstResponder()
        } else {
            didTapRegisterButton()
        }
        
        return true
    }
}
