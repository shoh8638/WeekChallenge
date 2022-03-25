//
//  UserViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/25.
//

import Foundation
import Firebase
import SDWebImage

struct UserViewModel {
    var UserM: UserModel
    
    func loadUserName() -> String {
        return UserM.userName
    }
    
    func loadUserImg(img: UIImageView){
        let imgUrl = UserM.imgUrl
        
        Storage.storage().reference(forURL: imgUrl).downloadURL { (url, error) in
            if url != nil {
               img.sd_setImage(with: url!, completed: nil)
            } else {
                print("SettingLoadData url err: \(error!)")
            }
        }
    }
}
