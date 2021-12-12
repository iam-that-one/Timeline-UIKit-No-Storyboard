//
//  ViewController2.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 10/12/2021.
//

import UIKit
import Firebase


class UsersViewController: UIViewController {
var user = FetchUsers()
    
    lazy var logOut : UIButton = {
        $0.setTitle("logout", for: .normal)
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(named: "btn"), for: .normal)
        $0.addTarget(self, action: #selector(logOutBtnClick), for: .touchDown)
    return $0
}(UIButton(type: .system))
    
    lazy var tableView : UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(UsersCell.self, forCellReuseIdentifier: "userCell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 200
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.layer.cornerRadius = 10
        return $0
    }(UITableView())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        user.fetchData()
        tableView.reloadData()
        print("I am UsersViewController")
        [logOut,tableView].forEach{view.addSubview($0)}
      //  view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
          
            
            logOut.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
             logOut.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            logOut.heightAnchor.constraint(equalToConstant: 40),
            logOut.widthAnchor.constraint(equalToConstant: 100),
            
            tableView.topAnchor.constraint(equalTo: logOut.bottomAnchor,constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20)

        ])
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        print("I am UsersViewController")
        user.fetchData()
        print(user.users)
        tableView.reloadData()
    }
}

extension UsersViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell",for: indexPath) as! UsersCell
        cell.uaername.text = user.users[indexPath.row].firstname
        cell.imgView.image = UIImage(systemName: "person.circle.fill")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatView = Chat()
       // chatView.modalPresentationStyle = .fullScreen
        chatView.id = user.users[indexPath.row].id
        chatView.name = user.users[indexPath.row].firstname
        self.present(chatView, animated: true, completion: nil)
    }
    @objc func logOutBtnClick(){
        do{
           try Auth.auth().signOut()
            let signInVC = LoginViewController()
            self.dismiss(animated: true, completion: nil)
            signInVC.modalPresentationStyle = .fullScreen
           self.present(signInVC, animated: true, completion: nil)
            
        }catch let error as NSError{
            print(error.userInfo)
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
