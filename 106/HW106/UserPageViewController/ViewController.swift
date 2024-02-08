//
//  ViewController.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 29.01.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var avatarCollectionView: UICollectionView!
    @IBOutlet weak var navigationUserLogin: UILabel!
    @IBOutlet weak var followsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    let countCells = 3
    let offset: CGFloat = 0.0
    var dataManager = StorageManager.shared
    let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let currentUserLogin = UserDefaults.standard.string(forKey: "currentUser")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.avatarCollectionView.dataSource = self
        self.avatarCollectionView.delegate = self
        avatarCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        avatarCollectionView.collectionViewLayout = layout
        navigationUserLogin.text = currentUserLogin
        setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = .clear
        avatarCollectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = .black
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "currentUser")
        if let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as? SceneDelegate {
            if let navController = myStoryboard.instantiateViewController(withIdentifier: "firstNavController") as? UINavigationController {
                sceneDelegate.window?.rootViewController = navController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
    @objc
    func tapToFollowsAction() {
        if let currentUser = getCurrentUser() {
            createFriendsVC(friendsList: Array(currentUser.follows))
        }
    }
    
    func setupGestures() {
        let tapGestureRecognizerToFoolows = UITapGestureRecognizer(target: self, action: #selector(tapToFollowsAction))
        followsLabel.isUserInteractionEnabled = true
        followsLabel.addGestureRecognizer(tapGestureRecognizerToFoolows)
    }
    
    func getCurrentUser() -> UserRegistration? {
        let users = dataManager.obtainSavedData()
        for user in users {
            if user.name == currentUserLogin {
                return user
            }
        }
        return nil
    }
    
    func createFriendsVC(friendsList: [UserRegistration]) {
        let friendaViewController = myStoryboard.instantiateViewController(withIdentifier: "FrendsViewController") as! FrendsViewController
        friendaViewController.configureUsersList(with: friendsList)
        present(friendaViewController, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let users = dataManager.obtainSavedData()
        for user in users {
            if user.name == currentUserLogin {
                return user.posts.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        let users = dataManager.obtainSavedData()
        for user in users {
            if user.name == currentUserLogin {
                let formatter4 = DateFormatter()
                formatter4.dateFormat = "dd-MM-yy"
                let posts = user.posts.sorted(by: { (formatter4.date(from: $0.date))! < (formatter4.date(from: $1.date))! })
                
                cell.setupCell(model: posts[indexPath.row])
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
            let frameCV = collectionView.frame
            let widthCell = frameCV.width / CGFloat(countCells)
            let heightCell = widthCell
            
            return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FullScreenViewController") as! FullScreenViewController
        vc.updateCollectionViewCompletion = {
            self.avatarCollectionView.reloadData()
        }
        vc.indexPath = indexPath
        vc.selectedItem = indexPath.item
//        vc.dataManager = self.dataManager
        present(vc, animated: true, completion: nil)
    }
}
