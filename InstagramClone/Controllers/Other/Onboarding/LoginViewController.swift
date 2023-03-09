//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by macbook pro on 7.03.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let userNameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
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
        return field
        
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let privacyButtpn: UIButton = {
        return UIButton()
    }()
    
    private let termsButton: UIButton = {
        return UIButton()
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create an Account", for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        header.backgroundColor = .red
        let backgroundImage = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImage)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 0,
                                  y: 0.0,
                                  width: view.width,
                                  height: view.height/3.0)
        
        userNameTextField.frame = CGRect(x: 25,
                                         y: headerView.bottom + 10,
                                         width: view.width-50,
                                         height: 52.0)
        
        passwordTextField.frame = CGRect(x: 25,
                                         y: userNameTextField.bottom + 10,
                                         width: view.width-50,
                                         height: 52.0)
        
        loginButton.frame = CGRect(x: 25,
                                   y: passwordTextField.bottom + 10,
                                   width: view.width - 50,
                                   height: 52.0)
        
        createAccountButton.frame = CGRect(x: 25,
                                           y: loginButton.bottom + 10,
                                           width: view.width - 50,
                                           height: 52.0)
        
        
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else { return }
        guard let backgroundView = headerView.subviews.first else { return }
        
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width/2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
        
        
        backgroundView.frame = headerView.bounds
    }
    
    private func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(userNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButtpn)
        view.addSubview(createAccountButton)
    }
    
    @objc private func didTapLoginButton() {}
    @objc private func didTapTermsButton() {}
    @objc private func didTapPrivacyButton() {}
    @objc private func didTapCreateAccountButton() {}
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            didTapLoginButton()
        }
        
        return true
    }
}
