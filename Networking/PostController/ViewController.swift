//
//  ViewController.swift
//  Networking
//
//  Created by Асанцев Владимир Дмитриевич on 07.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "PostCellID")
        }
    }
    
    var posts: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getAllPosts { [weak self] posts in
            DispatchQueue.main.async {
                self?.posts = posts
            }
        }
        
    }
    
    @IBAction func createPost(_ sender: Any) {
 
        
        let post = Post(userId: 1, title: "myTitle", body: "myBody")
        
        networkManager.postCreatePost(post) { postFromServer in
            post.id = postFromServer.id
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Great!", message: "Your post has benn created", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    alert.dismiss(animated: true, completion: nil)
                } //Алёрт пропадает через 3 секунды
            }
            
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellID", for: indexPath) as! PostTableViewCell
        cell.configure(posts[indexPath.row])
        return cell
    }
}

/*
 vc сильно держит networkManager (строка 14)
 НО networkManager НИКАК сильно не держит кложур (он его у себя в классе не сохраняет в переменную)
 
 –––––> поэтому ретейн цикла не возникает
 */
