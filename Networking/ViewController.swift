//
//  ViewController.swift
//  Networking
//
//  Created by Асанцев Владимир Дмитриевич on 07.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func downloadPostsDidTap() {
        networkManager.getAllPosts { posts in
            DispatchQueue.main.async {
                self.titleLabel.text = "Posts has been downloaded!"
            }
        }
    }
}
/*
 vc сильно держит networkManager (строка 14)
 НО networkManager НИКАК сильно не держит кложур (он его у себя в классе не сохраняет в переменную)
 
 –––––> поэтому ретейн цикла не возникает
 */
