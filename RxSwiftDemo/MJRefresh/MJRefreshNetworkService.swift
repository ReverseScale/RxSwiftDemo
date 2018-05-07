//
//  MJRefreshNetworkService.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/5/7.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import RxSwift
import RxCocoa

//网络请求服务
class MJRefreshNetworkService {
    
    //获取随机数据
    func getRandomResult() -> Driver<[String]> {
        print("正在请求数据......")
        let items = (0 ..< 15).map {_ in
            "随机数据\(Int(arc4random()))"
        }
        let observable = Observable.just(items)
        return observable
            .delay(1, scheduler: MainScheduler.instance)
            .asDriver(onErrorDriveWith: Driver.empty())
    }
}
