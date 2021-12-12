//
//  NewPostViewController.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 10/12/2021.
//

import UIKit
import Firebase
class NewPostViewController: UIViewController {
    var users = FetchUsers()
    var profImg : UIImage?
    var username : String?
    lazy var caption :  UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
        $0.backgroundColor = UIColor.lightGray
        return $0
    }(UITextView(frame: CGRect(x: 20.0, y: 90.0, width: 250.0, height: 100.0)))
    var toBeTransferedImage : UIImage?
    lazy var choosePostImage : UIButton = {
     $0.setTitle("choos image", for: .normal)
        $0.tintColor = .black
      //  $0.setBackgroundImage(UIImage(systemName: "photo.on.rectangle.angled"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(addImageBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var imgView : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "photo.artframe")
        $0.tintColor = .white
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    lazy var postIt : UIButton = {
        $0.setTitle("Post", for: .normal)
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(named: "btn"), for: .normal)
        $0.addTarget(self, action: #selector(postBtnCliclick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    override func viewWillAppear(_ animated: Bool) {
        print("I am NewPostController")

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        users.fetchData()
        getUserMetaDdata()
        view.backgroundColor = .darkGray
        setupUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // observe the keyboard status. If will show, the function (keyboardWillShow) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // observe the keyboard status. If will Hide, the function (keyboardWillHide) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        

        // Do any additional setup after loading the view.
    }
 
     func setupUI(){
        [choosePostImage,imgView,caption,postIt].forEach{view.addSubview($0)}
        NSLayoutConstraint.activate([
            choosePostImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            choosePostImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            
            imgView.topAnchor.constraint(equalTo: choosePostImage.bottomAnchor,constant: 20),
            imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgView.heightAnchor.constraint(equalToConstant: 300),
            imgView.widthAnchor.constraint(equalToConstant: 300),
            
            caption.topAnchor.constraint(equalTo: imgView.bottomAnchor,constant: 20),
            caption.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            caption.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            caption.bottomAnchor.constraint(equalTo: postIt.topAnchor,constant: -20),
            caption.heightAnchor.constraint(equalToConstant: 200),
            
          //  postIt.topAnchor.constraint(equalTo: caption.bottomAnchor),
            postIt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postIt.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            postIt.heightAnchor.constraint(equalToConstant: 40),
            postIt.widthAnchor.constraint(equalToConstant: 100),
            
            
            
        ])
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func addImageBtnClick(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        getUserMetaDdata()
    }
    
    @objc func postBtnCliclick(){
      
        if caption.text != "" && toBeTransferedImage != UIImage(){
            getUserMetaDdata()
            let newPost = Post(image: toBeTransferedImage ?? UIImage(named: "timelinePic") ?? UIImage(), caption: caption.text, email:Auth.auth().currentUser?.email ?? "", userName: self.username!, proImage: self.profImg ?? UIImage())
            newPost.uploadPost()
        }
    }
    // Move lofin view 300 points upward
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -300
    }

    // Move login view to original position
    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
}

extension NewPostViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        print("###########")
        imgView.image = image
        toBeTransferedImage = image
      //  print(toBeTransferedImage!.pngData())
        //self.postImage.setBackgroundImage(toBeTransferedImage!, for: .normal)
       
    }

    func getUserMetaDdata(){
        for user in users.users{
            if user.id == Auth.auth().currentUser?.uid{
                self.profImg = UIImage(data: user.image)
                self.username = user.firstname + " " + user.lastname
               // print(self.username)
                print(user.image)
                break
            }
        }
    }
}
