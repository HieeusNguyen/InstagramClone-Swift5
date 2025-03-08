//
//  Models.swift
//  InstagramClone
//
//  Created by Nguyễn Hiếu on 11/2/25.
//

import Foundation

enum Gender{
    case male, female, other
}

struct User{
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount{
    let followers: Int
    let following: Int
    let posts: Int
}

///Represent a user post
public struct UserPost{
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createDate: Date
    let taggedUsers: [String]
}

struct PostLike{
    let username: String
    let postIdentifier: String
}

struct CommentLike{
    let username: String
    let commentIdentifier: String
}

struct PostComment{
    let identifier: String
    let username: String
    let text: String
    let createDate: Date
    let likes: [CommentLike]
}
