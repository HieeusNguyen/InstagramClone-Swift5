//
//  AuthManager.swift
//  InstagramClone
//
//  Created by Nguyễn Hiếu on 16/1/25.
//

import Foundation
import FirebaseAuth

public class AuthManager{
    static let shared = AuthManager()
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void){
        /*
         - Check if username is available
         - Check if email is available
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate{
                /*
                 - Create account
                 - Insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard result != nil, error == nil else {
                        //Firebase auth could not create account
                        completion(false)
                        return
                    }
                    
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted{
                            // Succeded insert to database
                            completion(true)
                            return
                        }else{
                            //Failed to insert to database
                            completion(false)
                            return
                        }
                    }
                }
                
                //Insert into database
            }else{
                // either username or email does not exist
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion:  @escaping ((Bool) -> Void)){
        if let email = email{
            //email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return}
                completion(true)
            }
        }else if let username = username{
            //username log in
            print(username)
        }
    }
    
    ///Atemp to log out firebase user
    public func logOut(completion: ((Bool) -> Void)){
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }catch{
            print(error)
            completion(false)
            return
        }
    }
}
