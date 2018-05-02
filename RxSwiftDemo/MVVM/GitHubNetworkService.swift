//
//  GitHubNetworkService.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/5/2.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import RxSwift
import RxCocoa
import ObjectMapper

class GitHubNetworkService {
    
    //搜索资源数据
    func searchRepositories(query:String) -> Observable<GitHubRepositories> {
        return GitHubProvider.rx.request(.repositories(query))
            .filterSuccessfulStatusCodes()
            .mapObject(GitHubRepositories.self)
            .asObservable()
            .catchError({ error in
                print("发生错误：",error.localizedDescription)
                return Observable<GitHubRepositories>.empty()
            })
    }
}
