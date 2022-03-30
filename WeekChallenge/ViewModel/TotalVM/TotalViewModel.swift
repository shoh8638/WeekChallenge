//
//  TotalViewModel.swift
//  WeekChallenge
//
//  Created by 오승훈 on 2022/03/26.
//

import UIKit
import Firebase
import SDWebImage

struct TotalViewModel {
    let totalM: [TotalModel?]
    
    func numberOfRowsInSection() -> Int{
        return totalM.count
    }
    
    func numberOfCellIndex(index: Int) -> TotalModel {
        return totalM[index]!
    }
    
    func numberOfImg(index: Int) -> String {
        return totalM[index]!.userImg
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
    
    func totalUseImg(index: Int, img: UIImageView) {
        let imgUrl = totalM[index]!.userImg
        
        Storage.storage().reference(forURL: imgUrl).downloadURL { (url, error) in
            if url != nil {
               img.sd_setImage(with: url!, completed: nil)
            } else {
                print("PDetailViewModel url err: \(error!)")
            }
        }
    }
    func heightOfCell(collection: UICollectionView) -> CGSize {
        return CGSize(width: collection.bounds.width - 100, height: collection.bounds.height - 200)
    }
}
