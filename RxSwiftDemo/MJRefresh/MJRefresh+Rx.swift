//
//  MJRefresh+Rx.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/5/7.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import RxSwift
import RxCocoa
import MJRefresh

//对MJRefreshComponent增加rx扩展
extension Reactive where Base: MJRefreshComponent {
    
    //正在刷新事件
    var refreshing: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create {
            [weak control = self.base] observer  in
            if let control = control {
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
    
    //停止刷新
    var endRefreshing: Binder<Bool> {
        return Binder(base) { refresh, isEnd in
            if isEnd {
                refresh.endRefreshing()
            }
        }
    }
}
