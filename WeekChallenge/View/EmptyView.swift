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
    
    lazy var mainView: UIView = {
        let v = UIView()
        v.addSubview(mainButton)
        mainButton.snp.remakeConstraints { maker in
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
        backgroundColor = .white
        addSubview(mainView)
        mainView.snp.remakeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}
