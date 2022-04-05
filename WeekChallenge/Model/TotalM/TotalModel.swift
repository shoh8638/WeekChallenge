//
//  TotalModel.swift
//  WeekChallenge
//
//  Created by 오승훈 on 2022/03/26.
//

import Foundation
import SDWebImage
import Firebase

struct TotalModel {
    let dbID: String
    let title: String
    let userTitle: String
    let userImg: String
    let userText: String
    
    init(dbID: String, title: String, userTitle: String, userImg: String, userText: String) {
        self.dbID = dbID
        self.title = title
        self.userTitle = userTitle
        self.userImg = userImg
        self.userText = userText
    }
}

struct TotalDeatilModel {
    let userTitle: String
    let userImg: String
    let userText: String
    
    init(userTitle: String, userImg: String, userText: String) {
        self.userTitle = userTitle
        self.userImg = userImg
        self.userText = userText
    }
}

struct TotalDetailViewModel {
    let tDetailM: [TotalDeatilModel?]
    
    func numbeOfIndex() ->  Int {
        return tDetailM.count
    }
    
    func numberOfCellIndex(index: Int) -> TotalDeatilModel {
        return tDetailM[index]!
    }
    
    func numberOfImg(index: Int) -> String {
        return tDetailM[index]!.userImg
    }
    
    func loadUserImg(url: String, img: UIImageView){
        
        Storage.storage().reference(forURL: url).downloadURL { (url, error) in
            if url != nil {
               img.sd_setImage(with: url!, completed: nil)
            } else {
                print("PDetailViewModel url err: \(error!)")
            }
        }
    }
}
