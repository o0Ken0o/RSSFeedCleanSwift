//
//  LoginViewController.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit
import SnapKit

protocol LoginDisplayLogic: class {
    func displayLogin(viewModel: Login.TryLogin.ViewModel)
}

class LoginViewController: UIViewController {
    var router: LoginRoutingLogic?
    var interactor: LoginBusinessLogic?
    
    var usernameTF = UITextField()
    var passwordTF = UITextField()
    var submitBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        self.view.backgroundColor = .white
        
        setupVIPChain()
        
        addViewsToFormHierarchy()
        setupViews()
    }
    
    private func setupVIPChain() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    func addViewsToFormHierarchy() {
        self.view.addSubview(usernameTF)
        self.view.addSubview(passwordTF)
        self.view.addSubview(submitBtn)
    }
    
    func setupViews() {
        let tfStyleClosure: (UITextField) -> () = {
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.borderWidth = 2
            $0.layer.cornerRadius = 10
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            $0.leftViewMode = .always
        }
        
        usernameTF.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        usernameTF.autocapitalizationType = .none
        usernameTF.placeholder = "Enter your name"
        tfStyleClosure(usernameTF)
        
        passwordTF.snp.makeConstraints { (make) in
            make.centerX.equalTo(usernameTF)
            make.top.equalTo(usernameTF.snp.bottom).offset(10)
            make.left.right.height.equalTo(usernameTF)
        }
        passwordTF.isSecureTextEntry = true
        passwordTF.placeholder = "Enter your password"
        tfStyleClosure(passwordTF)
        
        submitBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(passwordTF)
            make.top.equalTo(passwordTF.snp.bottom).offset(10)
            make.left.right.height.equalTo(passwordTF)
        }
        submitBtn.setTitle("Login", for: .normal)
        submitBtn.layer.borderColor = UIColor.black.cgColor
        submitBtn.layer.borderWidth = 2
        submitBtn.layer.cornerRadius = 10
        submitBtn.backgroundColor = .black
        submitBtn.setTitleColor(.white, for: .normal)
        submitBtn.addTarget(self, action: #selector(submitBtnTapped(sender:)), for: .touchUpInside)
    }
    
    @objc func submitBtnTapped(sender: UIButton) {
        let username = usernameTF.text
        let password = passwordTF.text
        interactor?.tryLogin(request: Login.TryLogin.Request(username: username, password: password))
    }
    
    private func showAlertWith(title: String?, message: String?) {
        let alertCtrl = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertCtrl.addAction(okAction)
        self.present(alertCtrl, animated: true)
    }
}

extension LoginViewController: LoginDisplayLogic {
    func displayLogin(viewModel: Login.TryLogin.ViewModel) {
        if viewModel.isSuccessful {
            print("Logging the user in")
        } else {
            showAlertWith(title: "Error", message: viewModel.errorMsg)
        }
    }
}


