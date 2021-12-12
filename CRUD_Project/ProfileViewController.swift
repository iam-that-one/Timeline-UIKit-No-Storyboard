//
//  ProfileViewController.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 10/12/2021.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController {
    var posts = FetchPosts()
    var myPosts : [D_Post] = []
    lazy var myColletionView : UICollectionView? = nil
 
    
    override func viewWillAppear(_ animated: Bool) {
        print("I am ProfileController")
        posts.getPodts()
        print(Auth.auth().currentUser!.uid)
        for post in posts.posts{
        //    if post.id == Auth.auth().currentUser!.uid{
                self.myPosts.append(post)
         //   }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
               layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
               layout.itemSize = CGSize(width: 100, height: 100)
        
        myColletionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myColletionView!.backgroundColor = UIColor.white
        myColletionView!.dataSource = self
        myColletionView!.delegate = self
        myColletionView!.backgroundColor = .darkGray
        myColletionView!.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "coleectionViewCell")
        view.addSubview(myColletionView!)
        NSLayoutConstraint.activate([
            myColletionView!.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,constant: 20),
            myColletionView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myColletionView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
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

}

extension ProfileViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myColletionView!.dequeueReusableCell(withReuseIdentifier: "coleectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.backgroundColor = .darkGray
        cell.image.image = myPosts[indexPath.row].image
        return cell
    }
    
    
}
