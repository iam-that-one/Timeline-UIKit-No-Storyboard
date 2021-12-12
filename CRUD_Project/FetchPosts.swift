//
//  FetchPosts.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 10/12/2021.
//

import UIKit
import Firebase
import SwiftyJSON
class FetchPosts{
    
     var posts = [D_Post]()//.sorted(by: {$0.postID ?? "" > $1.postID ?? ""})
    
    // var post = D_Post()
   
    var dateFormatter: DateFormatter {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
    
    init(){
        Database.database().reference().child("posts").observe(.childAdded){(snapshot) in
            var image: UIImage!
            let json = JSON(snapshot.value as Any)
            let imageDownloadURL = json["imageDownloadURL"].stringValue
            let imagStorageRef = Storage.storage().reference(forURL: imageDownloadURL)
            imagStorageRef.getData(maxSize: 2 * 1024 * 1024, completion: {(data, error) in
                if error != nil{
                    print("Error download image")
                }
                else{
                    if let imageData = data{
                     image = UIImage(data: imageData)
                        let caption = json["caption"].stringValue
                        let id = json["id"].stringValue
                        let postID = json["postID"].stringValue
                        let edited = json["edited"].bool
                        let NumberOfLikes = json["NumberOfLikes"].int
                        let dates = json["date"].stringValue
                        let date = self.dateFormatter.date(from: dates)
                        let username = json["email"].stringValue
                        let userName = json["userName"].stringValue
                   //     let image = image
                        let newPost = D_Post(id: id ,caption: caption,imageDownloadURL: imageDownloadURL,image:  image,postID: postID,edited: edited,NumberOfLikes: NumberOfLikes,date: date,email: username,userName: userName)
                        
                        
                        self.posts.append(newPost)
                }
                }
            })
        }
    }
    
    func remove(postid : String?, img_url:String?){
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        let storage = Storage.storage().reference(forURL:img_url ?? "")

         // Remove the post from the DB
        ref.child("posts").child(postid ?? "").removeValue { error,arg  in
           if error != nil {
            print("error \(error!.localizedDescription)")
           }
           else{
            print(postid ?? "" + "deleted sucefully")
           }
            
         }
         // Remove the image from storage
        let imageRef = storage.child("images").child(uid ?? "").child("\(postid ?? "").jpg")
         imageRef.delete { error in
           if  error != nil {
            print(error!.localizedDescription)
           } else {
            // File deleted successfully
           }
         }
    }
    
    func getPodts(){
        Database.database().reference().child("posts").observe(.childAdded){(snapshot) in
            var image: UIImage!
            let json = JSON(snapshot.value as Any)
            let imageDownloadURL = json["imageDownloadURL"].stringValue
            let imagStorageRef = Storage.storage().reference(forURL: imageDownloadURL)
            imagStorageRef.getData(maxSize: 2 * 1024 * 1024, completion: {(data, error) in
                if error != nil{
                    print("Error download image")
                }
                else{
                    if let imageData = data{
                     image = UIImage(data: imageData)
                        let caption = json["caption"].stringValue
                        let id = json["id"].stringValue
                        let postID = json["postID"].stringValue
                        let edited = json["edited"].bool
                        let NumberOfLikes = json["NumberOfLikes"].int
                        let dates = json["date"].stringValue
                        let date = self.dateFormatter.date(from: dates)
                        let username = json["email"].stringValue
                        let userName = json["userName"].stringValue
                   //     let image = image
                        let newPost = D_Post(id: id ,caption: caption,imageDownloadURL: imageDownloadURL,image:  image,postID: postID,edited: edited,NumberOfLikes: NumberOfLikes,date: date,email: username,userName: userName)
                        
                        
                        self.posts.append(newPost)
                }
                }
            })
        }
    }
}

struct D_Post{
    var id = UUID().uuidString
    var caption : String!
    var imageDownloadURL : String?
    var image : UIImage!
    var postID : String?
    var edited : Bool?
    var NumberOfLikes : Int?
    var date : Date?
    var email : String!
    var userName : String!
}
