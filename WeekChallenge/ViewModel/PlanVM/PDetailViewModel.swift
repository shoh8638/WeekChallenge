//
//  PDetailViewModel.swift
//  WeekChallenge
//
//  Created by 오승훈 on 2022/03/25.
//

import Foundation
import Firebase
import SDWebImage

struct PDetailViewModel {
    let pDeatilM: [PDetailModel?]
    
    func numberOfRowsInSection() -> Int{
        return pDeatilM.count
    }
    
    func numberOfCellIndex(index: Int) -> PDetailModel {
        return pDeatilM[index]!
    }
    
    func numberOfImg(index: Int) -> String {
        return pDeatilM[index]!.img
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
