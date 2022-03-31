//
//  CompleteVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/11.
//

import UIKit

class CompleteVC: UIViewController, UIGestureRecognizerDelegate {
    
    var completeVM: RCSViewModel!
    
    @IBOutlet weak var completeTable: UITableView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var viewW: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        viewW.constant = UIScreen.main.bounds.width - 30
        LayoutService().onlyCornerApply(view: backView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        
        loadData()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func backTap(sender: UITapGestureRecognizer) {
        print("tap")
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData() {
        DataService().completeLoadData(table: completeTable) { model in
            self.completeVM = RCSViewModel(rcsM: model)
        }
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CompleteVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.completeVM != nil {
            if completeVM.numberOfRowInSection() == 0 {
                return 1
            } else {
                return self.completeVM.numberOfRowInSection()
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.completeVM != nil {
            if completeVM.numberOfRowInSection() == 0 {
                let cell = completeTable.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
                cell.emptyUpdate(info: "완료된 플랜이 없습니다.")
                return cell
            } else {
                let cell = completeTable.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
                let data = completeVM.numberOfCellIndex(index: indexPath.row)
                cell.rscUpdate(info: data)
                return cell
            }
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        completeVM.heightOfCell(table: completeTable)
    }
}

