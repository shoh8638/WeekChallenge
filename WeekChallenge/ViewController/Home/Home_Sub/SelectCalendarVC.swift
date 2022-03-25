//
//  SelectCalendarVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/10.
//

import UIKit

class SelectCalendarVC: UIViewController, UIGestureRecognizerDelegate {
    
    var date: String?
    
    var seletVM: RCSViewModel!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var selectCalendar: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        loadData()
        self.backView.layer.cornerRadius = 20
        self.backView.layer.masksToBounds = true
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
        DataService().selecetLoadData(table: selectCalendar, date: self.date!) { model in
            self.seletVM = RCSViewModel(rcsM: model)
        }
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
//MARK: UITableView
extension SelectCalendarVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.seletVM != nil {
            if seletVM.numberOfRowInSection() == 0 {
                return 1
            } else {
                return self.seletVM.numberOfRowInSection()
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.seletVM != nil {
            if seletVM.numberOfRowInSection() == 0 {
                let cell = selectCalendar.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
                cell.emptyUpdate(info: "플랜을 생성해주세요!")
                return cell
            } else {
                let cell = selectCalendar.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
                let data = seletVM.numberOfCellIndex(index: indexPath.row)
                cell.rscUpdate(info: data)
                return cell
            }
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        seletVM.selectHeightOfCell(table: selectCalendar)
    }
}
