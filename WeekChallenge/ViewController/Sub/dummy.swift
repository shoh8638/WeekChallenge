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
 */
