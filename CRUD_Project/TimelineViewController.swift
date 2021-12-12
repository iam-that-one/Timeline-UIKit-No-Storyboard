//
//  ViewController.swift
//  CRUD_Project
//
//  Created by Abdullah Alnutayfi on 10/12/2021.
//

import UIKit

class TimelineViewController: UIViewController {
var posts = FetchPosts()
    var users = FetchUsers()
    lazy var tableView : UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(TimelineCell.self, forCellReuseIdentifier: "cell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 600
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.layer.cornerRadius = 10
     //   $0.refreshControl = refreshControl
        return $0
    }(UITableView())
    override func viewWillAppear(_ animated: Bool) {
        print("I am TimelineViewController")
      //  posts.posts = []
      //  posts.getPosts()
        users.fetchData()
        print(posts.posts)
        tableView.reloadData()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.reloadData()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.title = "AAA"
        view.backgroundColor = .darkGray
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        print("I am TimelineViewController")
        // Do any additional setup after loading the view.
    }


}

extension TimelineViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! TimelineCell
//        for user in users.users{
//            if user.id == posts.posts[indexPath.row].id{
//                cell.username.text = user.firstname
//
//            }
//        }
        cell.timelineImage.image = posts.posts[indexPath.row].image
        cell.creationDate.text = dateFormatter.string(from:  posts.posts[indexPath.row].date ?? Date())
        cell.caption.text = posts.posts[indexPath.row].caption
        cell.username.text = posts.posts[indexPath.row].userName
        return cell
    }
   
    var dateFormatter: DateFormatter {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
}
