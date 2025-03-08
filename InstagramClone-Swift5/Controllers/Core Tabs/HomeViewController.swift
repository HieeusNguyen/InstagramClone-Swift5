//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Nguyễn Hiếu on 15/1/25.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identify)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleNotAuthenticated();
    }
    
    private func handleNotAuthenticated(){
        //Check auth status
        if Auth.auth().currentUser == nil{
            //Show log in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true)
        }
    }


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identify, for: indexPath) as! IGFeedPostTableViewCell
        return cell
    }
}
