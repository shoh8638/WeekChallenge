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
            maker.edges.equalTo(UIEdgeInsets(top: 200, left: 100, bottom: 200, right: 100))
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
