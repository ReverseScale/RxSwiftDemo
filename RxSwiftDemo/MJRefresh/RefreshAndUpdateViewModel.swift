//
//  RefreshAndUpdateViewModel.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/5/10.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import RxSwift
import RxCocoa

var tableData = BehaviorRelay<[String]>(value: [])

class RefreshAndUpdateViewModel: NSObject {
    //表格数据序列
    let tableDatas = BehaviorRelay<[String]>(value: [])
    
    //停止上拉加载刷新状态序列
    let endFooterRefreshing: Driver<Bool>
    
    //ViewModel初始化（根据输入实现对应的输出）
    init(footerRefresh: Driver<Void>,
         dependency: (
        disposeBag:DisposeBag,
        networkService: MJRefreshNetworkService )) {
        
        tableData = self.tableDatas
        
        //上拉结果序列
        let footerRefreshData = footerRefresh
            .startWith(()) //初始化完毕时会自动加载一次数据
            .flatMapLatest{ return dependency.networkService.getRandomResult() }
        
        //生成停止上拉加载刷新状态序列
        self.endFooterRefreshing = footerRefreshData.map{ _ in true }
        
        //上拉加载时，将查询到的结果拼接到原数据底部
        footerRefreshData.drive(onNext:{ items in
            tableData.accept(items)
        }).disposed(by: dependency.disposeBag)
    }
}
