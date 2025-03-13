//
//  PostViewController.swift
//  InstagramClone
//
//  Created by Nguyễn Hiếu on 15/1/25.
//

import UIKit

/*
 
 Section
 - Header Model
 Section
 - Post Cell Model
 Section
 - Action Buttons Cell Model
 Section
 - n Number of general models for comments
 
 */

/// States of a rendered cell
enum PostRenderType{
    case header(provider: User)
    case primaryContent(provider: UserPost) // post
    case actions(provider: String) // like, comment, share
    case comments(provider: [PostComment])
}

/// Model of rendered Post
struct PostRenderViewModel{
    let renderType: PostRenderType
}

class PostViewController: UIViewController {
    
    private let model: UserPost?
    
    private var renderModel = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        // Register cells
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identify)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identify)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identify)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identify)
        
        return tableView
    }()
    
    // MARK: - Init
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureModels(){
        guard let userPostModel = self.model else {return}
        // Header
        renderModel.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        // Post
        renderModel.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        // Actions
        renderModel.append(PostRenderViewModel(renderType: .actions(provider: "")))
        // Comments
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(PostComment(identifier: "123\(x)", username: "hieeeee", text: "Great post!", createDate: Date(), likes: []))
        }
        renderModel.append(PostRenderViewModel(renderType: .comments(provider: comments)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModel[section].renderType{
        case .actions(_):
            return 1
        case .comments(let comment):
            return comment.count > 4 ? 4 : comment.count
        case .primaryContent(_):
            return 1
        case .header(_):
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModel[indexPath.section]
        switch model.renderType{
        case .actions(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identify, for: indexPath) as! IGFeedPostActionsTableViewCell
            return cell
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identify, for: indexPath) as! IGFeedPostGeneralTableViewCell
            return cell
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identify, for: indexPath) as! IGFeedPostTableViewCell
            return cell
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identify, for: indexPath) as! IGFeedPostHeaderTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModel[indexPath.section]
        switch model.renderType{
        case .actions(_):
            return 60
        case .comments(let comment):
            return 50
        case .primaryContent(_):
            return tableView.width
        case .header(_):
            return 70
        }
    }
}

