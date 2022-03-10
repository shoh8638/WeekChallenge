//
//  MainVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/10.
//

import UIKit
import FirebaseFirestore
import Tabman
import Pageboy

class MainVC: TabmanViewController {
    
    private var viewControllers: Array<UIViewController> = []
    
    @IBOutlet weak var tabBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VCAppend()
        self.dataSource = self
        settingBar()
    }

    func VCAppend() {
        let vc1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppHome")
        let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppList")
        let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppBoard")
        let vc4 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppSetting")
        
        viewControllers.append(vc1)
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        viewControllers.append(vc4)
    }
    
}
//MARK: TabMan & Pageboy
extension MainVC: PageboyViewControllerDataSource, TMBarDataSource {
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "홈", image: UIImage(named: "home2.png")!)
        case 1:
            return TMBarItem(title: "리스트", image: UIImage(named: "icons8Reserve150.png")!)
        case 2:
            return TMBarItem(title: "게시글", image: UIImage(named: "fourSquareGridIcon.png")!)
        case 3:
            return TMBarItem(title: "설정", image: UIImage(named: "settingsMenuItem.png")!)
        default:
            return TMBarItem(title: "")
        }
    }
    
    func settingBar() {
        let bar = TMBar.TabBar()
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 18, right: 20)
        bar.buttons.customize { btn in
            btn.tintColor = .lightGray
            btn.selectedTintColor  = .black
            btn.backgroundColor = .clear
        }
        addBar(bar, dataSource: self, at: .custom(view: tabBar, layout: nil))
    }
}
