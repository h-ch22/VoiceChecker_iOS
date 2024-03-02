//
//  UserManagement.swift
//  VoiceChecker
//
//  Created by 하창진 on 3/3/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift

class UserManagement: ObservableObject{
    @Published var userInfo: UserInfoModel? = nil
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    func signIn(email: String, password: String, completion: @escaping(_ result: UserManagementAlertTypeModel?) -> Void){
        auth.signIn(withEmail: email, password: password){ _, error in
            if error != nil{
                completion(.UNKNOWN_ERROR)
                return
            }
            
            self.getUserInfo(completion: { result in
                guard let result = result else{return}
                
                completion(result ? .SUCCESS : .UNKNOWN_ERROR)
                return
            })
        }
    }
    
    func getUserInfo(completion: @escaping(_ result: Bool?) -> Void){
        db.collection("Users").document(auth.currentUser?.uid ?? "").getDocument(){ (document, error) in
            if error != nil{
                completion(false)
                return
            }
            
            if document != nil{
                let email = document?.get("email") as? String ?? ""
                let name = document?.get("name") as? String ?? ""
                let phone = document?.get("phone") as? String ?? ""
                let nickName = document?.get("nickName") as? String ?? ""
                
                self.userInfo = UserInfoModel(email: AES256Util.decrypt(encoded: email),
                                              name: AES256Util.decrypt(encoded: name),
                                              phone: AES256Util.decrypt(encoded: phone),
                                              nickName: AES256Util.decrypt(encoded: nickName))
                
                completion(true)
                return
            } else{
                completion(false)
                return
            }
        }
    }
    
    func signUp(email: String, password: String, name: String, phone: String, nickName: String, completion: @escaping(_ result: UserManagementAlertTypeModel?) -> Void){
        auth.createUser(withEmail: email, password: password, completion: { _, error in
            if error != nil{
                completion(.UNKNOWN_ERROR)
                return
            }
            
            self.setUserInfo(name: name, phone: phone, nickName: nickName, completion: { result in
                guard let result = result else{return}
                
                completion(result ? .SUCCESS : .UNKNOWN_ERROR)
                return
            })
        })
    }
    
    func setUserInfo(name: String, phone: String, nickName: String, completion: @escaping(_ result: Bool?) -> Void){
        db.collection("Users").document(auth.currentUser?.uid ?? "").setData([
            "email": AES256Util.encrypt(string: auth.currentUser?.email ?? ""),
            "name": AES256Util.encrypt(string: name),
            "phone": AES256Util.encrypt(string: phone),
            "nickName": AES256Util.encrypt(string: nickName)
        ]){ error in
            completion(error == nil)
            return
        }
    }
}
