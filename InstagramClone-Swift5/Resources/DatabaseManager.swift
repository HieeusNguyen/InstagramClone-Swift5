//
//  DatabaseManager.swift
//  InstagramClone
//
//  Created by Nguyễn Hiếu on 16/1/25.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager{
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    // MARK: - Public
    
    ///Check if username and email is available
    /// - Parameter
    ///     - email: String representing email
    ///     - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void){
        completion(true)
    }
    
    ///Insert new user data to database
    /// - Parameter
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for result if database entry succeded
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void){
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil{
                //succeded
                completion(true)
                return
            }else{
                //failed
                completion(false)
                return
            }
        }
    }
    
}
