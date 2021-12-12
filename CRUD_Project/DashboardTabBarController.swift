//
//  DashboardTabBarController.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 10/12/2021.
//

import UIKit

class DashboardTabBarController: UITabBarController, UITabBarControllerDelegate {
    var posts = FetchPosts()
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .darkGray
       // posts.getPosts()
        let item1 = TimelineViewController()
        let item2 = UsersViewController()
        let item3 = NewPostViewController()
        let item4 = ProfileViewController()

        
        let icon1 = UITabBarItem(title: "Timeline", image: UIImage(systemName: "timelapse"), selectedImage: UIImage(systemName: "timelapse"))
            item1.tabBarItem = icon1
        
        let icon2 = UITabBarItem(title: "Messeges", image: UIImage(systemName: "tray"), selectedImage: UIImage(systemName: "tray.fill"))
            item2.tabBarItem = icon2
        
        
        let icon3 = UITabBarItem(title: "New Post", image: UIImage(systemName: "plus.rectangle"), selectedImage: UIImage(systemName: "plus.rectangle.fill"))
            item3.tabBarItem = icon3
        
        let icon4 = UITabBarItem(title: "Grids", image: UIImage(systemName: "rectangle.grid.2x2"), selectedImage: UIImage(systemName: "rectangle.grid.2x2.fill"))
        item4.tabBarItem = icon4
      
       
        let controllers = [item3,item1,item2,item4]
        self.viewControllers = controllers
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true
    }
}
