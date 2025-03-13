//
//  IGFeedPostHeaderTableViewCell.swift
//  InstagramClone
//
//  Created by Nguyễn Hiếu on 5/2/25.
//

import UIKit

class IGFeedPostHeaderTableViewCell: UITableViewCell {

    static let identify = "IGFeedPostHeaderTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(){
        //configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
