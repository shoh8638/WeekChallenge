//
//  dummy.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/28.
//

import Foundation
/*
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
 */
