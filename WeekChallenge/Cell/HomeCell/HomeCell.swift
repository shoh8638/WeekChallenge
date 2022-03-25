//
//  HomeCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/25.
//

import UIKit

class homeCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var periodText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
}
