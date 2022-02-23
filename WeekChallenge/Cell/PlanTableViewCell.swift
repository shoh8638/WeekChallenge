//
//  PlanTableViewCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit

class PlanTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var planView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
/*
 view크기를 고정값을 지정
 버튼 라운딩 및 색처리
 ICon 이미지 선정 및 크기 지정
 */
