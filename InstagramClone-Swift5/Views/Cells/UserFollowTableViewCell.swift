//
//  UserFollowTableViewCell.swift
//  InstagramClone
//
//  Created by Nguyễn Hiếu on 13/2/25.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject{
    func didTapFollowUnfollowButton(model: UserRelationship)
}

enum FollowState{
    case following // Indicates the current user is following the other user
    case not_following //Indicates the current user is NOT following the other user
}

struct UserRelationship{
    let username: String
    let name: String
    let type: FollowState
}

class UserFollowTableViewCell: UITableViewCell {
    static let identifier = "UserFollowTableViewCell"
    
    public weak var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserRelationship?
    
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Hieu"
        return label
    }()
    
    private let usernameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "@hieu"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followButton: UIButton = {
       let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        usernameLabel.text = nil
        nameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    public func configure(with model: UserRelationship){
        self.model = model
        usernameLabel.text = model.username
        nameLabel.text = model.name
        switch model.type {
        case .following:
            //show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            //show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = contentView.height/2.0
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/3
        followButton.frame = CGRect(x: contentView.width-5-buttonWidth, y: (contentView.height-40)/2, width: buttonWidth, height: 40)
        followButton.layer.cornerRadius = followButton.height / 8
        let labelHeight = contentView.height/2
        nameLabel.frame = CGRect(x: profileImageView.right+5, y: 0, width: contentView.width-8-profileImageView.width-buttonWidth, height: labelHeight)
        usernameLabel.frame = CGRect(x: profileImageView.right+5, y: nameLabel.bottom, width: contentView.width-8-profileImageView.width-buttonWidth, height: labelHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapFollowersButton(){
        guard let model = model else {return}
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
}
