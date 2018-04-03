//
//  UserViewModel.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/3.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import RxSwift

struct UserViewModel {
    //用户名
    let username = Variable("guest")
    
    //用户信息
    lazy var userinfo = {
        return self.username.asObservable()
            .map{ $0 == "hangge" ? "您是管理员" : "您是普通访客" }
            .share(replay: 1)
    }()
}
