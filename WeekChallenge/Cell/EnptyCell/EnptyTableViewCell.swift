//
//  EnptyTableViewCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/23.
//

import UIKit

class EnptyTableViewCell: UITableViewCell {
    
    var vc: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func createButton(_ sender: Any) {
        let createBtn = UIStoryboard(name: "Main", bundle:  nil).instantiateViewController(withIdentifier: "createVC") as! CreatePlanVC
        vc?.present(createBtn, animated: translatesAutoresizingMaskIntoConstraints, completion: nil)
    }
    
}
