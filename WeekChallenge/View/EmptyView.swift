//
//  EmptyView.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/10.
//

import UIKit

protocol ButtonAction {
    func touchUpEvent()
}

class EmptyView: UIView {
        
    var delegate: ButtonAction?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        emptyView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        emptyView()
    }
    
    func emptyView() {
        let view = Bundle.main.loadNibNamed("EmptyView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func newButton(_ sender: UIButton) {
        delegate?.touchUpEvent()
    }
}
