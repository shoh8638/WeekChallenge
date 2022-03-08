//
//  dummy.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/28.
//

import Foundation
/*
 
 guard let userID = Auth.auth().currentUser?.email else { return }
 let randomNum = arc4random_uniform(999999)
 let data = ["Title": "", "Image": "", "Text": ""]
 var dateArr = [String]()
 for i in date {
     dateArr.append(i.key)
 }
 
 db.collection(userID).document("\(folderName)+\(randomNum)").setData([
     "Title": folderName,
     "\(dateArr[0])": data,
     "\(dateArr[1])": data,
     "\(dateArr[2])": data,
     "\(dateArr[3])": data,
     "\(dateArr[4])": data,
     "Dates": dateArr
 ]) { err in
     guard err == nil else {
         return print("createDB err: \(err!)")
     }
     print("createDB Success")
 }
 
 
 self.db.collection(userID).document(document.documentID).getDocument { (rowDocument, err) in
     if let rowDocument = rowDocument, document.exists {
         let dates = (rowDocument["Dates"] as! [String]).sorted(by: <)
         let completion = rowDocument["Completion"] as? [String]
         
         for i in 0...dates.count-1 {
             let dateFields = rowDocument[dates[i]] as! [String: String]
             let text = dateFields["Text"]
             self.exDB[document.documentID] = completion
         }
         
         
//                                        self.exDB[document.documentID] = dates
//                                        print(self.exDB)
         
        
         for i in 0...dates.count-1 {
             let date = rowDocument["\(i)"] as? String
             if date == nil {
                 dbDate.append(0)
             } else {
                 dbDate.append(1)
             }
         }
         self.dbDate.append(dbDate)

     }
 }
 
 
 
 
 
 if indexPath.section == 0 {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "search", for: indexPath) as! searchCell
     cell.name.text = self.dbTitles[indexPath.row]
     return cell
 } else if indexPath.section == 1 {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "img", for: indexPath) as! imgCell
     return cell
 } else {
     let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "text", for: indexPath) as! textCell
     cell.title.text = self.userTitles[indexPath.row]
     cell.text.text = self.userText[indexPath.row]
     return cell
 }
 
 
 //
 //  EmptyView.swift
 //  WeekChallenge
 //
 //  Created by shoh on 2022/02/10.
 //

 import UIKit
 import SnapKit

 class EmptyView: UIView {
     
     lazy var mainButton: UIButton = {
         let b = UIButton(type: .custom)
         b.backgroundColor = .lightGray
         b.setTitle("조회중", for: .normal)
         b.setTitleColor(.white, for: .normal)
         b.layer.cornerRadius = 10
         return b
     }()
     
     lazy var subText: UILabel = {
         let t = UILabel()
         t.text = "조회중"
         t.textColor = .black
         t.backgroundColor = .lightGray
         return t
     }()
     
     lazy var mainView: UIView = {
         let v = UIView()
         v.addSubview(mainButton)
         mainButton.snp.remakeConstraints { maker in
             maker.edges.equalTo(UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100))
             maker.height.equalTo(100)
             maker.width.equalTo(100)
         }
         return v
     }()
     
     lazy var subView: UIView = {
         let v = UIView()
         v.addSubview(subText)
         subText.snp.remakeConstraints { maker in
             maker.center.equalToSuperview()
         }
         return v
     }()
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupView()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         setupView()
     }
     
     func setupView() {
         let vStack = UIStackView(arrangedSubviews: [mainView,subView])
         vStack.axis = .vertical
         vStack.spacing = 3
         backgroundColor = .white
         addSubview(vStack)
         vStack.snp.remakeConstraints { maker in
             maker.edges.equalToSuperview()
         }
     }
 }

 
 
 
 //
 //  SelectedList.swift
 //  WeekChallenge
 //
 //  Created by shoh on 2022/02/15.
 //

 import UIKit
 import SnapKit

 class SelectedList: UIView {
     
     lazy var firstTitleButton: UIButton = {
         let b = UIButton(type: .custom)
         b.backgroundColor = .white
         b.setTitle("5일차", for: .normal)
         b.setTitleColor(.brown, for: .normal)
         b.titleLabel?.font = .boldSystemFont(ofSize: 18.0)
         return b
     }()
     
     lazy var secondTitleButtonl: UIButton = {
         let b = UIButton(type: .custom)
         b.backgroundColor = .white
         b.setTitle("10일차", for: .normal)
         b.setTitleColor(.brown, for: .normal)
         b.titleLabel?.font = .boldSystemFont(ofSize: 18.0)
         return b
     }()
     
     lazy var thirdTitleButton: UIButton = {
         let b = UIButton(type: .custom)
         b.backgroundColor = .white
         b.setTitle("15일차", for: .normal)
         b.setTitleColor(.brown, for: .normal)
         b.titleLabel?.font = .boldSystemFont(ofSize: 18.0)
         return b
     }()
     
     lazy var firstTap: UIView = {
         let v = UIView()
         v.addSubview(firstTitleButton)
         firstTitleButton.snp.makeConstraints { make in
             make.edges.equalToSuperview()
         }
         return v
     }()
         
     lazy var secondTap: UIView = {
         let v = UIView()
         v.addSubview(secondTitleButtonl)
         secondTitleButtonl.snp.makeConstraints { make in
             make.edges.equalToSuperview()
         }
         return v
     }()
     
     lazy var thirdTap: UIView = {
         let v = UIView()
         v.addSubview(thirdTitleButton)
         thirdTitleButton.snp.makeConstraints { make in
             make.edges.equalToSuperview()
         }
         return v
     }()
     
     lazy var firstTapLine: UIView = {
         let v = UIView()
         v.backgroundColor = .lightGray
         v.snp.remakeConstraints { make in
             make.height.equalTo(1.0)
             make.width.equalTo(0.0)
         }
         return v
     }()
         
     lazy var secondTapLine: UIView = {
         let v = UIView()
         v.backgroundColor = .lightGray
         v.snp.remakeConstraints { make in
             make.height.equalTo(1.0)
             make.width.equalTo(0.0)
         }
         return v
     }()
     
     lazy var thirdTapLine: UIView = {
         let v = UIView()
         v.backgroundColor = .lightGray
         v.snp.remakeConstraints { make in
             make.height.equalTo(1.0)
             make.width.equalTo(0.0)
         }
         return v
     }()
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         initialized()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         initialized()
     }
     
     func initialized() {
         let vStack = UIStackView(arrangedSubviews: [firstTap,firstTapLine,secondTap,secondTapLine,thirdTap,thirdTapLine])
         vStack.axis = .vertical
         vStack.alignment = .center
         vStack.spacing = 10
         vStack.distribution = .fillEqually
         vStack.backgroundColor = .white
         self.addSubview(vStack)
         vStack.snp.makeConstraints { make in
             make.edges.equalTo(UIEdgeInsets(top: 300, left: 50, bottom: 300, right: 50))
             make.center.equalToSuperview()
         }
     }
 }

 */
