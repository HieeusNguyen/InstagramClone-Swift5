//
//  ExploreViewController.swift
//  InstagramClone
//
//  Created by Nguyễn Hiếu on 15/1/25.
//

import UIKit

final class ExploreViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .secondarySystemBackground
        return searchBar
    }()
    
    private var models = [UserPost]()
    
    private var collectionView: UICollectionView?
    
    private var tabbedSearchCollectionView: UICollectionView?
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchBar()
        configureExploreCollection()
        configureDimmedView()
    }
    
    private func configureExploreCollection(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.width/3 - 2, height: view.width/3 - 2)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        guard let collectionView = collectionView else {return}
        view.addSubview(collectionView)
    }
    
    private func configureSearchBar(){
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
    }
    
    private func configureDimmedView(){
        view.addSubview(dimmedView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        dimmedView.addGestureRecognizer(gesture)
    }
    
    private func configureTabbedSearch(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.width/3, height: 52)
        layout.scrollDirection = .horizontal
        tabbedSearchCollectionView?.backgroundColor = .yellow
        tabbedSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tabbedSearchCollectionView?.isHidden = true
        guard let tabbedSearchCollectionView = tabbedSearchCollectionView else { return }
        tabbedSearchCollectionView.delegate = self
        tabbedSearchCollectionView.dataSource = self
        view.addSubview(tabbedSearchCollectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        dimmedView.frame = view.bounds
//        tabbedSearchCollectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 72)
    }
    
}

extension ExploreViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didCancelSearch()
        searchBar.resignFirstResponder()
        guard let text = searchBar.text, !text.isEmpty else {return}
        query(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelSearch))
        dimmedView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.alpha = 0.4
        } completion: { done in
            if done {
                self.tabbedSearchCollectionView?.isHidden = false
            }
        }

    }
    
    @objc private func didCancelSearch(){
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        self.tabbedSearchCollectionView?.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.alpha = 0
        } completion: { done in
            if done {
                self.dimmedView.isHidden = true
            }
        }

    }
    
    private func query(_ text: String){
        //perform the search in the back end
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabbedSearchCollectionView{
            return 0
        }
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabbedSearchCollectionView{
            return UICollectionViewCell()
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {return UICollectionViewCell()}
//        cell.configure(with: <#T##UserPost#>)
        cell.configure(debug: "test")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView == tabbedSearchCollectionView{
            // change search context
            return
        }
        let user = User(username: "hieeus.ngx", bio: "", name: (first: "", last: ""), profilePhoto: URL(string: "https://www.google.com")!, birthDate: Date(), gender: .female, counts: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())
        let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likeCount: [], comments: [], createDate: Date(), taggedUsers: [], owner: user)
        let vc = PostViewController(model: post)
        vc.title = post.postType.rawValue
        navigationController?.pushViewController(vc, animated: true)
    }
}
