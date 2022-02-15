//
//  CustomView.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit

class CustomView {
    func addView(v: UIView) {
        lazy var emptyView : EmptyView = {
            let view = EmptyView()
            return view
        }()
        
        v.addSubview(emptyView)
        emptyView.snp.remakeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        emptyView.mainButton.addTarget(self, action: #selector(emptyClick), for: .touchUpInside)
    }
    
    @objc func emptyClick(sender: UIButton? = nil) {
        print("Tap")
    }
}
