//
//  EnptyCollectionViewCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/02.
//

import UIKit
import LSHContributionView

class EnptyCollectionViewCell: UICollectionViewCell {
    
    var vc: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func createButton(_ sender: Any) {
        let createBtn = UIStoryboard(name: "Main", bundle:  nil).instantiateViewController(withIdentifier: "createVC") as! CreatePlanVC
        vc?.present(createBtn, animated: translatesAutoresizingMaskIntoConstraints, completion: nil)
    }
    
}

class CreatePlanVC: UIViewController {
    
    @IBOutlet weak var fiveView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        OneView()
    }
}

//MARK: Button
extension CreatePlanVC {
    @IBAction func fiveDayPlan(_ sender: Any) {
//        CustomAlert().createPlan(vc: self, day: "5일", date: PlanDate().fiveDate())
    }
}

//MARK: View Update
extension CreatePlanVC {
    func OneView() {
        let dataSquare = [ [0,1,2,3,4]]
        let contributeView = LSHContributionView(frame: CGRect(x: 0, y: 0, width: fiveView.bounds.width, height: fiveView.bounds.height))
        contributeView.data = dataSquare
        contributeView.colorScheme = "Halloween"
        fiveView.addSubview(contributeView)
    }
}
