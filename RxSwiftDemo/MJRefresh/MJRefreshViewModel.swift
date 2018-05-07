//
//  MJRefreshViewModel.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/5/7.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import RxSwift
import RxCocoa

class MJRefreshViewModel {
    
    //表格数据序列
    let tableData:Driver<[String]>
    
    //停止刷新状态序列
    let endHeaderRefreshing: Driver<Bool>
    
    //ViewModel初始化（根据输入实现对应的输出）
    init(headerRefresh: Driver<Void>) {
        
        //网络请求服务
        let networkService = MJRefreshNetworkService()
        
        //生成查询结果序列
        self.tableData = headerRefresh
            .startWith(()) //初始化完毕时会自动加载一次数据
            .flatMapLatest{ _ in networkService.getRandomResult() }
        
        //生成停止刷新状态序列
        self.endHeaderRefreshing = self.tableData.map{ _ in true }
    }
}
