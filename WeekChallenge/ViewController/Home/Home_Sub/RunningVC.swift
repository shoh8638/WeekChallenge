//
//  RunningVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/11.
//

import UIKit

class RunningVC: UIViewController, UIGestureRecognizerDelegate {

    var runVM: RunViewModel!
    
    @IBOutlet weak var runningTable: UITableView!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        ApplyService().onlyCornerApply(view: backView)
        getstureTap()
        loadData()
    }
    
    func loadData() {
        DataService().runLoadData(table: runningTable) { model in
            self.runVM = RunViewModel(runM: model)
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
        print("tap")
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
                let cell = runningTable.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! homeCell
                cell.title.text = "플랜을 생성해주세요!"
                cell.periodText.text = ""
                return cell
            } else {
                let cell = runningTable.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! homeCell
                let data = runVM.numberOfCellIndex(index: indexPath.row)
                cell.title.text = data.title!
                cell.periodText.text = "\(data.firstDate!) ~ \(data.lastDate!)"
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
