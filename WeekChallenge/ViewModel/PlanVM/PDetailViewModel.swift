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
    
    func loadUserImg(index: Int, img: UIImageView){
        let imgUrl = pDeatilM[index]!.img
        
        Storage.storage().reference(forURL: imgUrl).downloadURL { (url, error) in
            if url != nil {
               img.sd_setImage(with: url!, completed: nil)
            } else {
                print("PDetailViewModel url err: \(error!)")
            }
        }
    }
}
