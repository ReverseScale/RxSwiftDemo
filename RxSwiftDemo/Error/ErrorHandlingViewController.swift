//
//  ErrorHandlingViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/3/28.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum MyError: Error {
    case A
    case B
}

class ErrorHandlingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func catchErrorJustReturnAction(_ sender: Any) {
        createCatchErrorJustReturn()
    }
    
    @IBAction func catchErrorAction(_ sender: Any) {
        createCatchError()
    }
    
    @IBAction func retryAction(_ sender: Any) {
        createRetry()
    }
    func createRetry() {
        let disposeBag = DisposeBag()
        var count = 1
        
        let sequenceThatErrors = Observable<String>.create { observer in
            observer.onNext("a")
            observer.onNext("b")
            
            //让第一个订阅时发生错误
            if count == 1 {
                observer.onError(MyError.A)
                print("Error encountered")
                count += 1
            }
            
            observer.onNext("c")
            observer.onNext("d")
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        sequenceThatErrors
            .retry(2)  //重试2次（参数为空则只重试一次）
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    func createCatchError() {
        let disposeBag = DisposeBag()
        
        let sequenceThatFails = PublishSubject<String>()
        let recoverySequence = Observable.of("1", "2", "3")
        
        sequenceThatFails
            .catchError {
                print("Error:", $0)
                return recoverySequence
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("a")
        sequenceThatFails.onNext("b")
        sequenceThatFails.onNext("c")
        sequenceThatFails.onError(MyError.A)
        sequenceThatFails.onNext("d")
    }
    
    
    func createCatchErrorJustReturn() {
        let disposeBag = DisposeBag()
        
        let sequenceThatFails = PublishSubject<String>()
        sequenceThatFails
            .catchErrorJustReturn("错误")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("a")
        sequenceThatFails.onNext("b")
        sequenceThatFails.onNext("c")
        sequenceThatFails.onError(MyError.A)
        sequenceThatFails.onNext("d")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
