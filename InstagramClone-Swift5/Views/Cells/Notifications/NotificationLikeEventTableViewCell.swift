//
//  NotificationLikeEventTableViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Nguyễn Hiếu on 9/3/25.
//

import UIKit

protocol NotificationLikeEventTableViewCellDelegate: AnyObject{
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {

    static let identifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .label
        profileImageView.layer.masksToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        return profileImageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "hieeus.ngx liked your photo."
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "test"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubview(profileImageView)
        addSubview(label)
        addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapPostButton(){
        guard let model = model else {return}
        delegate?.didTapRelatedPostButton(model: model)
    }
    
    public func configure(with model: UserNotification){
        self.model = model
        switch model.type{
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else {return}
            postButton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
        case .follow:
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //photo, text, post button
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = contentView.height/2
        let size = contentView.height-4
        postButton.frame = CGRect(x: contentView.width-size-5, y: 2, width: size, height: size)
        label.frame = CGRect(x: profileImageView.right+5, y: 0, width: contentView.width-profileImageView.width-size-16, height: contentView.height)
    }
}

