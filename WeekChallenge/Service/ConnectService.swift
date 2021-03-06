//
//  ConnectService.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/04.
//

import UIKit
import Alamofire

class ConnectService {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func Network(view: UIViewController) {
        if !ConnectService.isConnectedToInternet {
            let alert = UIAlertController(title: "알림", message: "네트워크 연결이 안되어있습니다", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default) { _ in
                exit(0)
            }
            alert.addAction(action)
            view.present(alert, animated: true, completion: nil)
        }
    }
    
    func sendVC(main: UIViewController, name: String) {
        guard let vc = main.storyboard?.instantiateViewController(withIdentifier: name) else { return }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        main.present(vc, animated: true, completion: nil)
    }
}
