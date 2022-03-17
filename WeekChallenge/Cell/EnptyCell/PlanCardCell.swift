////
////  PlanCardCell.swift
////  WeekChallenge
////
////  Created by shoh on 2022/03/03.
////
//
//import UIKit
//import Firebase
//
//class PlanCardCell: CardCell {
//
//    @IBOutlet weak var backView: UIView!
//    @IBOutlet weak var icon: UIImageView!
//    @IBOutlet weak var titleBtn: UIButton!
//    @IBOutlet weak var LSHView: UIView!
//    @IBOutlet weak var imageView: UIImageView!
//    
//    var documentID: String?
//    var titles: String?
//    var viewController: UIViewController?
//    let db = Firestore.firestore()
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//    
//    func setView() {
//        backView.layer.cornerRadius = 0.5
//    }
//    
//    @IBAction func sendWrite(_ sender: Any) {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "writeVC") as! WriteVC
//        vc.documentID = self.documentID!
//        vc.titles = self.titles!
//        viewController?.present(vc, animated: true, completion: nil)
//    }
//    
//    @IBAction func modifyWrite(_ sender: Any) {
//        let alert = UIAlertController(title: "알림" , message: "타이틀 수정하시겠습니까??" , preferredStyle: .alert)
//        
//        alert.addTextField { text in
//            text.placeholder = "타이틀 수정해주세요!"
//        }
//        
//        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
//                let titleText = (alert.textFields?[0].text)!
//                self.modify(title: titleText)
//        }
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
//        alert.addAction(okAction)
//        alert.addAction(cancelAction)
//        self.viewController?.present(alert, animated: true)
//    }
//    
//    @IBAction func removeWrite(_ sender: Any) {
//        let alert = UIAlertController(title: "알림", message: "삭제하시겠습니가?", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
//            self.remove()
//        }
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
//        alert.addAction(okAction)
//        alert.addAction(cancelAction)
//        viewController?.present(alert, animated: true, completion: nil)
//    }
//    
//    func modify(title: String) {
//        guard let userID = Auth.auth().currentUser?.email else {return}
//        let path = self.db.collection(userID).document(self.documentID!)
//        var map = [String: String]()
//        map["Title"] = title
//        path.updateData(map)
//    }
//    
//    func remove() {
//        guard let userID = Auth.auth().currentUser?.email else {return}
//        self.db.collection(userID).document(documentID!).delete()
//    }
//}
