//
//  CompleteVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/11.
//

import UIKit

class CompleteVC: UIViewController, UIGestureRecognizerDelegate {
    
    let lbVM =  ListBtnViewModel()
    var lbM = ListBtnModel()
    
    @IBOutlet weak var completeTable: UITableView!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        
        ApplyService().onlyCornerApply(view: backView)
        
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
        DataService().cLoadData(table: completeTable) { model in
            self.lbM = model
        }
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CompleteVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lbVM.numberOfItem(lbMdel: self.lbM)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = completeTable.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! homeCell
        cell.title.text = lbVM.numberOfTitle(lbModel: lbM, index: indexPath.row)
        cell.periodText.text = lbVM.numberOfPeriod(lbMdel: lbM, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.lbM.titles.count == 0 {
            return self.completeTable.frame.height
        } else {
            return self.completeTable.frame.height/3
        }
    }
}

