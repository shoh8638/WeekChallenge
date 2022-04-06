//
//  TotalDetailViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/04/06.
//

import UIKit
import Firebase
import SDWebImage

struct TotalDetailViewModel {
    let tDetailM: TotalDeatilModel?
    
    func numbeOfIndex() ->  Int {
        return 1
    }
    
    func numberOfCellIndex() -> TotalDeatilModel? {
        return tDetailM
    }
    
    func loadUserImg(img: UIImageView){
        Storage.storage().reference(forURL: tDetailM!.userImg).downloadURL { (url, error) in
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

