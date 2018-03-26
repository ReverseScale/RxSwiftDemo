//
//  SubjectsViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/3/26.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SubjectsViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPublishSubject()
        
        createBehaviorSubject()

        createReplaySubject()
        
        createVariable()
    }
    
    func createPublishSubject() {
        //创建一个PublishSubject
        let subject = PublishSubject<String>()
        
        //由于当前没有任何订阅者，所以这条信息不会输出到控制台
        subject.onNext("111")
        
        //第1次订阅subject
        subject.subscribe(onNext: { string in
            print("第1次订阅：", string)
        }, onCompleted:{
            print("第1次订阅：onCompleted")
        }).disposed(by: disposeBag)
        
        //当前有1个订阅，则该信息会输出到控制台
        subject.onNext("222")
        
        //第2次订阅subject
        subject.subscribe(onNext: { string in
            print("第2次订阅：", string)
        }, onCompleted:{
            print("第2次订阅：onCompleted")
        }).disposed(by: disposeBag)
        
        //当前有2个订阅，则该信息会输出到控制台
        subject.onNext("333")
        
        //让subject结束
        subject.onCompleted()
        
        //subject完成后会发出.next事件了。
        subject.onNext("444")
        
        //subject完成后它的所有订阅（包括结束后的订阅），都能收到subject的.completed事件，
        subject.subscribe(onNext: { string in
            print("第3次订阅：", string)
        }, onCompleted:{
            print("第3次订阅：onCompleted")
        }).disposed(by: disposeBag)
        
        print("---------")
    }

    func createBehaviorSubject() {
        let disposeBag = DisposeBag()
        
        //创建一个BehaviorSubject
        let subject = BehaviorSubject(value: "111")
        
        //第1次订阅subject
        subject.subscribe { event in
            print("第1次订阅：", event)
            }.disposed(by: disposeBag)
        
        //发送next事件
        subject.onNext("222")
        
        //发送error事件
        subject.onError(NSError(domain: "local", code: 0, userInfo: nil))
        
        //第2次订阅subject
        subject.subscribe { event in
            print("第2次订阅：", event)
            }.disposed(by: disposeBag)
        
        print("---------")
    }
    
    func createReplaySubject() {
        // ReplaySubject 在创建时候需要设置一个 bufferSize，表示它对于它发送过的 event 的缓存个数。
        let disposeBag = DisposeBag()
        
        //创建一个bufferSize为2的ReplaySubject
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        
        //连续发送3个next事件
        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")
        
        //第1次订阅subject
        subject.subscribe { event in
            print("第1次订阅：", event)
            }.disposed(by: disposeBag)
        
        //再发送1个next事件
        subject.onNext("444")
        
        //第2次订阅subject
        subject.subscribe { event in
            print("第2次订阅：", event)
            }.disposed(by: disposeBag)
        
        //让subject结束
        subject.onCompleted()
        
        //第3次订阅subject
        subject.subscribe { event in
            print("第3次订阅：", event)
            }.disposed(by: disposeBag)
        
        print("---------")
    }
    
    func createVariable() {
        //创建一个初始值为111的Variable
        let variable = Variable("111")
        
        //修改value值
        variable.value = "222"
        
        //第1次订阅
        variable.asObservable().subscribe {
            print("第1次订阅：", $0)
            }.disposed(by: disposeBag)
        
        //修改value值
        variable.value = "333"
        
        //第2次订阅
        variable.asObservable().subscribe {
            print("第2次订阅：", $0)
            }.disposed(by: disposeBag)
        
        //修改value值
        variable.value = "444"
        
        print("---------")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
