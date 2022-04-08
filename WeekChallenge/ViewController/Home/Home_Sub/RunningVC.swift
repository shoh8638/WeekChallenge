//
//  RunningVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/11.
//

import UIKit

class RunningVC: UIViewController, UIGestureRecognizerDelegate {

    var runVM: RCSViewModel!
    
    @IBOutlet weak var runningTable: UITableView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var viewW: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        viewW.constant = UIScreen.main.bounds.width - 30
        LayoutService().onlyCornerApply(view: backView)
        getstureTap()
        loadData()
    }
    
    func loadData() {
        DataService().runLoadData(table: runningTable) { model in
            self.runVM = RCSViewModel(rcsM: model)
        }
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: Gesture
extension RunningVC {
    func getstureTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func backTap(sender: UITapGestureRecognizer) {
        print("RunningVC_backTap")
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: TableViewDataSource
extension RunningVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.runVM != nil {
            if runVM.numberOfRowInSection() == 0 {
                return 1
            } else {
                return self.runVM.numberOfRowInSection()
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.runVM != nil {
            if runVM.numberOfRowInSection() == 0 {
                let cell = runningTable.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
                cell.emptyUpdate(info: "진행중인 플랜이 없습니다.")
                return cell
            } else {
                let cell = runningTable.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
                let data = runVM.numberOfCellIndex(index: indexPath.row)
                cell.rscUpdate(info: data)
                return cell
            }
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        runVM.heightOfCell(table: runningTable)
    }
}
