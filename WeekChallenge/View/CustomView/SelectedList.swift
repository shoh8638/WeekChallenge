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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initialized() {
        let vStack = UIStackView(arrangedSubviews: [firstTap,firstTapLine,secondTap,secondTapLine,thirdTap,thirdTapLine])
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.distribution = .fillEqually
        self.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
