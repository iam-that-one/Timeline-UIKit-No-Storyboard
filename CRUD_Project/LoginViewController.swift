//
//  LoginViewController.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 10/12/2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
  //  let appDellegat : AppDelegate? = nil
    let user = Auth.auth().currentUser
    lazy var appName : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Timeline App"
        
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return $0
    }(UILabel())
    
    lazy var logo : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "87-870269_taking-deep-breaths-time-frame-clipart")
        $0.tintColor = .white
        return $0
    }(UIImageView())
    
    lazy var email : UITextField = {
        $0.placeholder = "Email"
        $0.text = "ccsi-iuni@hotmail.com"
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var password : UITextField = {
        $0.placeholder = "Password"
        $0.text = "123456"
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var signIn : UIButton = {
        $0.setTitle("Login", for: .normal)
        $0.tintColor = .black
        $0.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(named: "btn"), for: .normal)
        $0.addTarget(self, action: #selector(signInBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var signUpLabel : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Don't have an account?"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        return $0
    }(UILabel())
    lazy var signUp : UIButton = {
        $0.setTitle("signUp", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(signUpBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        print("I am LoginViewController")
        navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        uiSettings()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // observe the keyboard status. If will show, the function (keyboardWillShow) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // observe the keyboard status. If will Hide, the function (keyboardWillHide) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
   
    func uiSettings(){
        [appName,logo,email,password,signIn,signUpLabel,signUp].forEach{view.addSubview($0)}
        NSLayoutConstraint.activate([
        appName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 150),
        appName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        logo.topAnchor.constraint(equalTo: appName.bottomAnchor,constant: 20),
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        logo.heightAnchor.constraint(equalToConstant: 230),
        logo.widthAnchor.constraint(equalToConstant: 200),
        
        email.topAnchor.constraint(equalTo: logo.bottomAnchor,constant: 40),
        email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        email.widthAnchor.constraint(equalToConstant: 300),
        
        password.topAnchor.constraint(equalTo: email.bottomAnchor,constant: 20),
        password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        password.widthAnchor.constraint(equalToConstant: 300),
        
        signIn.topAnchor.constraint(equalTo: password.bottomAnchor,constant: 20),
        signIn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        signIn.heightAnchor.constraint(equalToConstant: 50),
        signIn.widthAnchor.constraint(equalToConstant: 300),
        
        signUpLabel.topAnchor.constraint(equalTo: signIn.bottomAnchor,constant: 20),
        signUpLabel.leadingAnchor.constraint(equalTo: signIn.leadingAnchor,constant: 40),

        signUp.firstBaselineAnchor.constraint(equalTo: signUpLabel.firstBaselineAnchor),
        signUp.leadingAnchor.constraint(equalTo: signUpLabel.trailingAnchor,constant: 10)
        
        ])
    }
    @objc func signInBtnClick(){
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { result, error in
            if let error = error{
                print(error)
            }else{
                let dashBoard = DashboardTabBarController()
                dashBoard.modalPresentationStyle = .fullScreen
                self.present(dashBoard, animated: true, completion: nil)
               // self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func signUpBtnClick(){
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        self.present(signUpVC, animated: true
                                           , completion: nil)
    }
    // Move lofin view 300 points upward
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -300
    }

    // Move login view to original position
    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
