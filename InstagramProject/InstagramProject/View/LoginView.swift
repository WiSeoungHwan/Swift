//
//  LoginView.swift
//  InstargramProject
//
//  Created by Wi on 05/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

protocol LoginViewDelegate {
    func loginButtonDidTab(id: String?, pw: String?)
    func forgetPWButtonDidTab()
}
class LoginView: UIView {
    private let instagramLogoStr = "instagramLogo"
    private let logoImageView = UIImageView()
    private let idTextField = UITextField()
    private let pwTextField = UITextField()
    private let loginButton = UIButton()
    private let forgetPWButton = UIButton()
    var delegate: LoginViewDelegate?
    let margin: CGFloat = 10
    
    override init(frame: CGRect) {// Use Code
        super.init(frame: frame)
        configure()
        autoLayOut()
    }
    required init?(coder aDecoder: NSCoder) {// Use Storyboard
        super.init(coder: aDecoder)
        configure()
        autoLayOut()
    }
    
    
    
    
    @objc func buttonDidtap(_ sender: UIButton){
        switch sender {
        case loginButton:
            print("loginButtonViewTab")
            delegate?.loginButtonDidTab(id: idTextField.text, pw: pwTextField.text)
        case forgetPWButton:
            delegate?.forgetPWButtonDidTab()
        default:
            break
        }
    }
    
    func configure(){
        
        //logo
        logoImageView.image = UIImage(named: instagramLogoStr)
        logoImageView.contentMode = .center
        
        //textfield
        idTextField.backgroundColor = UIColor.white
        idTextField.placeholder = "아이디"
        idTextField.textAlignment = .left
        idTextField.borderStyle = .roundedRect
        
        pwTextField.backgroundColor = UIColor.white
        pwTextField.placeholder = "비밀번호"
        pwTextField.textAlignment = .left
        pwTextField.borderStyle = .roundedRect
        pwTextField.isSecureTextEntry = true
        
        //button
        forgetPWButton.backgroundColor = .white
        forgetPWButton.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        forgetPWButton.titleLabel?.textAlignment = .right
        forgetPWButton.setTitleColor(.blue, for: .normal)
        forgetPWButton.setTitleColor(.gray, for: .selected)
        forgetPWButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        forgetPWButton.addTarget(self, action: #selector(buttonDidtap), for: .touchUpInside)
        
        loginButton.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 1, alpha: 0.5)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("로그인", for: .normal)
        loginButton.titleLabel?.textAlignment = .center
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(buttonDidtap), for: .touchUpInside)
        
        
        //autoLayout
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        pwTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        forgetPWButton.translatesAutoresizingMaskIntoConstraints = false
        
        //addSubView
        self.addSubview(logoImageView)
        self.addSubview(idTextField)
        self.addSubview(pwTextField)
        self.addSubview(forgetPWButton)
        self.addSubview(loginButton)
        
    }
    func autoLayOut(){
        logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 150).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        idTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30).isActive = true
        idTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin).isActive = true
        idTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        idTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        pwTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 10).isActive = true
        pwTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin).isActive = true
        pwTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        pwTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        forgetPWButton.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 10).isActive = true
        forgetPWButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: forgetPWButton.bottomAnchor, constant: 30).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 1).isActive = true
        //        loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    
    
}

