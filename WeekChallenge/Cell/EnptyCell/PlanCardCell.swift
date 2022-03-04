//
//  PlanCardCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/03.
//

import UIKit
import VerticalCardSwiper
import Firebase

class PlanCardCell: CardCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleBtn: UIButton!
    @IBOutlet weak var LSHView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var documentID: String?
    var viewController: UIViewController?
    let db = Firestore.firestore()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setView() {
        backView.layer.cornerRadius = 0.5
    }
    @IBAction func sendWrite(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "writeVC") as! WriteVC
        vc.documentID = self.documentID!
        viewController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func modifyWrite(_ sender: Any) {
        //알림으로 Ok시 수정, 아니면 dismiss -> 메시지에 타이틀 수정한다고 표기
    }
    
    @IBAction func removeWrite(_ sender: Any) {
        //알림 추가하고 삭제한다고 Ok눌렀으면 삭제, 아니면 dismiss
        remove()
    }
    
    func modify() {
        guard let userID = Auth.auth().currentUser?.email else {return}
        self.db.collection(userID).document(documentID!).setData(["Title" : ""])
    }
    
    func remove() {
        guard let userID = Auth.auth().currentUser?.email else {return}
        self.db.collection(userID).document(documentID!).delete()
    }
}
