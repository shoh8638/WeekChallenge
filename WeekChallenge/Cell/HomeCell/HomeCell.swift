//
//  HomeCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/25.
//

import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var periodText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        LayoutService().applyHomeCellShadow(cell: self)
    }
    
    func rscUpdate(info: RSCModel) {
        title.text = info.title
        periodText.text = "\(info.firstDate!) ~ \(info.lastDate!)"
    }
    
    func emptyUpdate(info: String) {
        title.text = info
        periodText.text = ""
    }
    
    func dataUpdate(info: DataModel) {
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        title.text = info.title
        periodText.text = "\(info.firstDate!) ~ \(info.lastDate!)"
    }
}
