//
//  UserInfoModel.swift
//  VoiceChecker
//
//  Created by 하창진 on 3/3/24.
//

import Foundation

struct UserInfoModel: Hashable{
    var email: String
    var name: String
    var phone: String
    var nickName: String
    
    init(email: String, name: String, phone: String, nickName: String) {
        self.email = email
        self.name = name
        self.phone = phone
        self.nickName = nickName
    }
}
