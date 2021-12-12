//
//  ViewModel.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 10/12/2021.
//

import UIKit
import Firebase

class Post{
    var caption : String!
    var imageDownloadURL : String?
    var image : UIImage!
    var id = Auth.auth().currentUser?.uid
    var postID : String?
    var NumberOfLikes : Int?
    var date = Date()
    var email : String!
    var userName : String!
    var proImageDownloadURL : String?
    var proImage : UIImage!

    
    var dateFormatter: DateFormatter {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
    
    init(image: UIImage, caption:String, email : String, userName : String,proImage : UIImage)  {
        self.image = image
        self.caption = caption
        self.email = email
        self.userName = userName
        self.proImage = proImage
    }
   
    func convertImage(_ image : UIImage) -> Data{
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {return Data()}
        return imageData
    }
    func uploadPost(){
        // datebase Reference
        let newPostRef = Database.database().reference().child("posts").childByAutoId()
        let newPostKey = newPostRef.key
        
        
        // create  a storage reference
        let imageStorageRef = Storage.storage().reference().child("images")
        let newImageRef = imageStorageRef.child(newPostKey!)
        
        // save image to storage
       
        newImageRef.putData(convertImage(image),metadata: nil){(metadata,error) in
            guard let metadata = metadata else {
                return
            }
            _ = metadata.size
            newImageRef.downloadURL { (url, error) in
                guard url != nil else {
                    print(error!.localizedDescription)
                    return
                }
                self.imageDownloadURL = url?.absoluteString ?? "NO URL"
            
          
                
                        // // // // // // // // // // //
                        
                        
                        
                        // // // // // // // // // // //
                
                // // // // // // // // // // //
                self.postID = newPostKey ?? ""
                let newPostDictionary = [
                    "imageDownloadURL" : self.imageDownloadURL ?? "",
                    "caption" : self.caption ?? "",
                    "id" : self.id ?? "",
                    "postID" : self.postID ?? "",
                    "NumberOfLikes" : self.NumberOfLikes ?? 0,
                    "date":  self.dateFormatter.string(from: self.date),
                    "email" : self.email ?? "",
                    "userName" : self.userName ?? ""
                    
                ]
                as [String : Any]
                newPostRef.setValue(newPostDictionary)
            
            }
        }
        
        }
}
