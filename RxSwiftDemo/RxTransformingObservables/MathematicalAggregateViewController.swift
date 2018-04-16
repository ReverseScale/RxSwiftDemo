//
//  MathematicalAggregateViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/3/27.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MathematicalAggregateViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Mathematical & Aggregate"

        createToArray()
        
        createReduce()
        
        createConcat()
    }
    
    func createToArray() {
        // 该操作符先把一个序列转成一个数组，并作为一个单一的事件发送，然后结束。
        Observable.of(1, 2, 3)
            .toArray()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func createReduce() {
        // reduce 接受一个初始值，和一个操作符号。
        Observable.of(1, 2, 3, 4, 5)
            .reduce(0, accumulator: +)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func createConcat() {
        // concat 会把多个 Observable 序列合并（串联）为一个 Observable 序列。
        let subject1 = BehaviorSubject(value: 1)
        let subject2 = BehaviorSubject(value: 2)
        
        let variable = Variable(subject1)
        variable.asObservable()
            .concat()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject2.onNext(2)
        subject1.onNext(1)
        subject1.onNext(1)
        subject1.onCompleted()
        
        variable.value = subject2
        subject2.onNext(2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
