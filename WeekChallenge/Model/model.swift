//
//  model.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/25.
//

import Foundation

struct model {
    let UserName: String?
    let Email: String?

}
struct modelList {
    let ml: [model]
}

struct modelView {
    let vm: [model]
    
    var numberOfSection: Int {
        return 1
    }
    
    func numberOfRow(_section: Int) -> Int {
        return self.vm.count
    }
    func index(index: Int) -> viewmodel {
        let a = self.vm[index]
        return viewmodel(m: a)
    }
    func bb(index: Int) {
        let a = self.vm[index]
        print(viewmodel(m:a).UserName!)
        print(viewmodel(m:a).Email!)
    }
}

struct viewmodel {
    let m: model
    
    init(m: model){
        self.m = m
    }
    var UserName: String? {
        return self.m.UserName
    }
    var Email: String? {
        return self.m.Email
    }
}
