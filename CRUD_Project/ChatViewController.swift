//
//  ChatViewController.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 11/12/2021.
//

import UIKit
import FirebaseFirestore
import Firebase
class Chat: UIViewController {
    var users = FetchUsers()
    var myName  = ""
    var hisName = ""
    let firestore = Firestore.firestore()
    let myId = Auth.auth().currentUser?.uid
    var id : String?
    var name : String?
    var messages: [Message] = []
    
    lazy var logo : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "person.circle.fill")
       // $0.tintColor = .white
        return $0
    }(UIImageView())
    
    lazy var chatTableView : UITableView = {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 200
        $0.register(MyChatCell.self, forCellReuseIdentifier: "chatCell")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        
        return $0
    }(UITableView())
    
    lazy var messageTextField : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())
    
    lazy var sedBtn : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Send", for: .normal)
        $0.addTarget(self, action: #selector(sendMSG), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    override func viewDidLoad() {
      
        super.viewDidLoad()
       // getName()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // observe the keyboard status. If will show, the function (keyboardWillShow) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // observe the keyboard status. If will Hide, the function (keyboardWillHide) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
        _ = getUserData()
        fetchMesssages()
        print(id!, name!)
        view.backgroundColor = .white
        view.addSubview(chatTableView)
        view.addSubview(messageTextField)
        view.addSubview(sedBtn)
        view.addSubview(logo)
        NSLayoutConstraint.activate([
            
            
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logo.heightAnchor.constraint(equalToConstant: 80),
            logo.widthAnchor.constraint(equalToConstant: 80),
            
            chatTableView.topAnchor.constraint(equalTo: logo.bottomAnchor,constant:20),
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            chatTableView.bottomAnchor.constraint(equalTo: messageTextField.topAnchor),
            
           // messageTextField.topAnchor.constraint(equalTo: chatTableView.bottomAnchor,constant: 20),
            messageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            messageTextField.widthAnchor.constraint(equalToConstant: 300),
            messageTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            sedBtn.leadingAnchor.constraint(equalTo: messageTextField.trailingAnchor,constant: 10),
            sedBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
          
        ])
        
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func sendMSG(){
       // getName()
        let msg = ["content": messageTextField.text!, "id": myId, "date" : dateFormatter.string(from: Date()), "Name" : getUserData()]
        print("*******\(myName)")
        let myId = Auth.auth().currentUser?.uid
        firestore.collection("Users").document(myId!)
            .collection("Message").document(self.id!).collection("msg").document().setData(msg as [String : Any])
        
        
        firestore.collection("Users").document(self.id!)
            .collection("Message").document(myId!).collection("msg").document().setData(msg as [String : Any])
        fetchMesssages()
    }
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.dateStyle = .full
        formatter.timeStyle = .full
        formatter.timeZone = TimeZone(secondsFromGMT: 3)
        return formatter
    }()
    // Move lofin view 300 points upward
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -300
    }

    // Move login view to original position
    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
}

extension Chat : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "chatCell",for: indexPath) as! MyChatCell
       
        cell.username.text = messages[indexPath.row].name
        cell.message.text = messages[indexPath.row].content
        //cell.layer.cornerRadius = 10
        //cell.backgroundColor = UIColor.systemIndigo
        return cell
    }
    
    func fetchMesssages(){
       
        firestore.collection("Users").document(myId!)
            .collection("Message").document(self.id!).collection("msg")
            .order(by: "date")
            .addSnapshotListener { (querySnapshot, error) in
                self.messages = []
                if let e = error {
                    print(e)
                }else {
                    if let snapshotDocuments = querySnapshot?.documents{
                        for document in snapshotDocuments {
                            let data = document.data()
                            if  let msg = data["content"] as? String,
                            let id = data["id"] as? String,
                                let date = data["date"] as? String,
                                let name = data["Name"] as? String
                            {
                                let fetchedMessage = Message(content: msg, id: id, date: date, name: name)
                                self.messages.append(fetchedMessage)
                                DispatchQueue.main.async {
                                    self.chatTableView.reloadData()
                                    
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    func getUserData() -> String{
        users.fetchData()
        for user in users.users{
            if user.id == Auth.auth().currentUser?.uid{
                self.logo.image = UIImage(data: user.image)
                self.myName = user.firstname
               // print(self.username)
                print(user.image)
                break
            }
        }
        return self.myName
    }
    
}


struct Message {
    let content: String
    let id : String
    let date : String
    let name : String
}

