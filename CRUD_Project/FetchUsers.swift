//
//  FetchUsers.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 10/12/2021.
//

import Foundation
import Firebase
class FetchUsers{
    var users = [User]()
    
    
    private let db = Firestore.firestore()
    
    func fetchData(){
        db.collection("Users").addSnapshotListener { (QuerySnapshot, error) in
            guard let document = QuerySnapshot?.documents else{
                return
            }
            self.users = document.map({ (QueryDocumentSnapshot) -> User in
                let data = QueryDocumentSnapshot.data()
                let id = data["userID"] as? String ?? ""
                let firstname = data["firstName"] as? String ?? "NO VALUE"
                let lastname = data["lastName"] as? String ?? "NO VALUE"
                //let displayedName = data["displayedName"] as? String ?? "NO VALUE"
                let email = data["email"] as? String ?? "NO VALUE"
                let image = data["profilePic"] as? Data ?? Data()
              //  let website = data["website"] as? String ?? "NO VALUE"
              //  let bio = data["bio"] as? String ?? "NO VALUE"
                
                return User(id: id,firstname: firstname, lastname: lastname,email: email,image: image)
            })
        }
    }
}

struct User: Identifiable {
    var id : String = UUID().uuidString
    var firstname : String
    var lastname : String
   // var displayedName : String
    var email : String
    var image : Data
  //  var website : String
  //  var bio : String
}
