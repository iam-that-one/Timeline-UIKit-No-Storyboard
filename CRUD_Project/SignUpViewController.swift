//
//  SignUpViewController.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 10/12/2021.
//

import UIKit
import Firebase
class SignUpViewController: UIViewController {
    let db = Firestore.firestore()
    var proImage : UIImage?
    lazy var profilePic : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        $0.addTarget(self, action: #selector (selectImageBtnClick), for: .touchDown)
        $0.tintColor = .white
        return $0
    }(UIButton(type: .system))
    
    lazy var email : UITextField = {
        $0.placeholder = "Email"
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var firstName : UITextField = {
        $0.placeholder = "First Name"
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var lastName : UITextField = {
        $0.placeholder = "Last Name"
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var password : UITextField = {
        $0.placeholder = "Password"
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var passwordConfirm : UITextField = {
        $0.placeholder = "Password confirm"
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var signUp : UIButton = {
        $0.setTitle("SignUp", for: .normal)
        $0.tintColor = .black
        $0.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(named: "btn"), for: .normal)
        $0.addTarget(self, action: #selector(signUpInBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var cancelBtn : UIButton = {
        $0.setTitle("Have an account? Please login", for: .normal)
        $0.tintColor = .black
        $0.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
      //  $0.setBackgroundImage(UIImage(named: "btn"), for: .normal)
        $0.addTarget(self, action: #selector(cancelCreatingNewUser), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    override func viewWillAppear(_ animated: Bool) {
        print("I am SignUpViewController")

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        title = "Creating a new account"
        setUpUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // observe the keyboard status. If will show, the function (keyboardWillShow) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // observe the keyboard status. If will Hide, the function (keyboardWillHide) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
    }
    private func setUpUI(){
        [profilePic,email,firstName,lastName,password,passwordConfirm,signUp,cancelBtn].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            profilePic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            profilePic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePic.heightAnchor.constraint(equalToConstant: 200),
            profilePic.widthAnchor.constraint(equalToConstant: 200),
            
            email.topAnchor.constraint(equalTo: profilePic.bottomAnchor,constant: 20),
            email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            email.widthAnchor.constraint(equalToConstant: 300),
            
            firstName.topAnchor.constraint(equalTo: email.bottomAnchor,constant: 20),
            firstName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstName.widthAnchor.constraint(equalToConstant: 300),
            
            lastName.topAnchor.constraint(equalTo: firstName.bottomAnchor,constant: 20),
            lastName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastName.widthAnchor.constraint(equalToConstant: 300),
            
            password.topAnchor.constraint(equalTo: lastName.bottomAnchor,constant: 20),
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.widthAnchor.constraint(equalToConstant: 300),
            
            passwordConfirm.topAnchor.constraint(equalTo: password.bottomAnchor,constant: 20),
            passwordConfirm.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordConfirm.widthAnchor.constraint(equalToConstant: 300),
            
            signUp.topAnchor.constraint(equalTo: passwordConfirm.bottomAnchor,constant: 20),
            signUp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUp.widthAnchor.constraint(equalToConstant: 300),
            signUp.heightAnchor.constraint(equalToConstant: 50),
            
            cancelBtn.topAnchor.constraint(equalTo: signUp.bottomAnchor,constant: 20),
            cancelBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelBtn.widthAnchor.constraint(equalToConstant: 300),
            cancelBtn.heightAnchor.constraint(equalToConstant: 50)
            
            
            
            
        ])
    }
    
    @objc private func signUpInBtnClick(){
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { result, error in
            if let error = error{
                print(error)
            }else{
               
                let data : [String: Any] = ["firstName":self.firstName.text!,"lastName":self.lastName.text!,"email":self.email.text!,"userID":Auth.auth().currentUser!.uid , "displayName" : self.firstName.text!]
                
                self.db.collection("Users").addDocument(data: data) { error in
                    if let error = error{
                        print(error)
                    }else{
                        let tabView = DashboardTabBarController()
                        self.navigationController?.present(tabView, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc private func selectImageBtnClick(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .photoLibrary
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    @objc private func cancelCreatingNewUser(){
        self.dismiss(animated: true, completion: nil)
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
    func convertImage(image : UIImage) -> Data{
        return image.jpegData(compressionQuality: 0.1) ?? Data()
    }
}

extension SignUpViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        print("###########")
        profilePic.setBackgroundImage(image, for: .normal)
        self.proImage = image
       
    }
}
