//
//  HomeVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/10.
//

import UIKit
import Firebase
import LSHContributionView


class HomeVC: UIViewController {
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var contributionView: UIView!
    @IBOutlet weak var wecolmeText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connectivity().Network(view: self)
        checkUser()
        LSHView()
    }
    
    @IBAction func planChoice(_ sender: Any) {
    }
        
    func checkUser() {
        if let userID = Auth.auth().currentUser?.email {
            Database().checkDB(userID: userID) { count in
                let num = count as! Int
                if num > 1 {
                    self.wecolmeText.text = "현재 \(num-1)개 플랜이 실행중입니다!"
                } else {
                    self.wecolmeText.text = "버튼을 눌러 플랜을 생성해주세요!"
                }
            }
        }
    }
    
    func LSHView() {
        let dataSquare = [ [0,1,2,3,4]]
        let contributeView = LSHContributionView(frame: CGRect(x: 0, y: 0, width: contributionView.bounds.width, height: contributionView.bounds.height))
        contributeView.data = dataSquare
        contributeView.colorScheme = "Halloween"
        contributionView.addSubview(contributeView)
    }
    
    @IBAction func settingButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppSetting") as! SettingVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
