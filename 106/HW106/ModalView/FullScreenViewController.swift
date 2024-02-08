//
//  FullScreenViewController.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 30.01.2024.
//

import UIKit

class FullScreenViewController: UIViewController {
    
    var dataManager = DataBaseManager.shared
    var storageManager = StorageManager.shared
    var indexPath: IndexPath!
    var selectedItem: Int!
    var updateCollectionViewCompletion: (() -> Void)?
    var isFromTabbarController = true
    
    @IBOutlet weak var constraintsWithStories: NSLayoutConstraint!
    @IBOutlet weak var constraintsWithoutStories: NSLayoutConstraint!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tabBarController == nil {
            isFromTabbarController = false
            storiesCollectionView.isHidden = true
            constraintsWithStories.priority = UILayoutPriority.defaultLow
            constraintsWithoutStories.priority = UILayoutPriority.defaultHigh
        } else {
            isFromTabbarController = true
            storiesCollectionView.isHidden = false
            constraintsWithStories.priority = UILayoutPriority.defaultHigh
            constraintsWithoutStories.priority = UILayoutPriority.defaultLow
        }
        
        collectionView.register(UINib(nibName: "FullScreenCell", bundle: nil), forCellWithReuseIdentifier: "FullScreenCell")
        storiesCollectionView.register(UINib(nibName: "StoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoriesCollectionViewCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.storiesCollectionView.delegate = self
        self.storiesCollectionView.dataSource = self
        
        navigationItem.setHidesBackButton(true, animated: true);
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tabBarController?.navigationItem.hidesBackButton = true
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard isFromTabbarController == false else { return }
        let indexPath = IndexPath(item: selectedItem, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard isFromTabbarController == true, getAllPosts().isEmpty == false else { return }
        let indexPath = IndexPath(row: 0, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: false)
    }
    
    func getSortedPostsOfUSer(user: UserRegistration) -> [Post] {
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "dd-MM-yy"
        let posts = user.posts.sorted(by: { (formatter4.date(from: $0.date))! < (formatter4.date(from: $1.date))! })
        return posts
    }
    
    func getAllPosts() -> [Post] {
        let allUsers = storageManager.obtainSavedData()
        var allPosts: [Post] = []
        allUsers.forEach({ allPosts.append(contentsOf: $0.posts)})
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "dd-MM-yy"
        return allPosts.sorted(by: { (formatter4.date(from: $0.date))! < (formatter4.date(from: $1.date))! })
    }
}
extension FullScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.storiesCollectionView { return dataManager.dataSource.count }
        guard isFromTabbarController == false else { return getAllPosts().count }
        let currentUserLogin = UserDefaults.standard.string(forKey: "currentUser")
        let users = storageManager.obtainSavedData()
        for user in users {
            if user.name == currentUserLogin {
                let posts = getSortedPostsOfUSer(user: user)
                return posts.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.storiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoriesCollectionViewCell", for: indexPath) as! StoriesCollectionViewCell
            let model = dataManager.dataSource[indexPath.item]
            cell.setupCell(model: model)
            return cell
        } else if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullScreenCell", for: indexPath) as! FullScreenCell
            let currentUserLogin = UserDefaults.standard.string(forKey: "currentUser")
            var model: Post?
            let users = storageManager.obtainSavedData()
            for user in users {
                if user.name == currentUserLogin {
                    if isFromTabbarController == false {
                        let formatter4 = DateFormatter()
                        formatter4.dateFormat = "dd-MM-yy"
                        let posts = user.posts.sorted(by: { (formatter4.date(from: $0.date))! < (formatter4.date(from: $1.date))! })
                        model = posts[indexPath.item]
                    } else {
                        model = getAllPosts()[indexPath.item]
                    }
                }
            }
            
            
            cell.presentCompletion = { alert in
                self.present(alert, animated: true)
            }
            if self.isFromTabbarController == false {
                cell.deleteCompletion = {
                    if let model = model {
                        try? self.storageManager.delete(model)
                        self.dismiss(animated: true, completion: self.updateCollectionViewCompletion)
                    }
                }
            } else {
                if model?.login == currentUserLogin {
                    cell.deleteCompletion = {
                        if let model = model {
                            try? self.storageManager.delete(model)
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
            cell.setupCell(model: model)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(
                width: self.collectionView.frame.width,
                height: self.collectionView.frame.height
            )
        } else if collectionView == self.storiesCollectionView {
            return CGSize(
                width: self.storiesCollectionView.frame.height,
                height: self.storiesCollectionView.frame.height
            )
        }
        return CGSize(
            width: self.collectionView.frame.width,
            height: self.collectionView.frame.height
        )
    }
}
