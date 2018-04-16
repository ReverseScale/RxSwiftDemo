//
//  GrammarsViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/3/23.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GrammarsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "RxSwift 基本语法"
        view.backgroundColor = UIColor.white
        
    }
    @IBAction func createTestAction(_ sender: Any) {
        //这个block有一个回调参数observer就是订阅这个Observable对象的订阅者
        //当一个订阅者订阅这个Observable对象的时候，就会将订阅者作为参数传入这个block来执行一些内容
        let observable = Observable<String>.create{observer in
            //对订阅者发出了.next事件，且携带了一个数据"hangge.com"
            observer.onNext("hangge.com")
            //对订阅者发出了.completed事件
            observer.onCompleted()
            //因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
            return Disposables.create()
        }
        //订阅测试
        observable.subscribe {
            print($0)
        }
    }
    
    @IBAction func deferredTestAction(_ sender: Any) {
        //用于标记是奇数、还是偶数
        var isOdd = true
        //使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回。
        let factory : Observable<Int> = Observable.deferred {
            //让每次执行这个block时候都会让奇、偶数进行交替
            isOdd = !isOdd
            //根据isOdd参数，决定创建并返回的是奇数Observable、还是偶数Observable
            if isOdd {
                return Observable.of(1, 3, 5 ,7)
            }else {
                return Observable.of(2, 4, 6, 8)
            }
        }
        //第1次订阅测试
        factory.subscribe { event in
            print("\(isOdd)", event)
        }
        //第2次订阅测试
        factory.subscribe { event in
            print("\(isOdd)", event)
        }
    }
    @IBAction func intervalTestAction(_ sender: Any) {
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable.subscribe { event in
            print(event)
        }
    }
    @IBAction func timerTestAction(_ sender: Any) {
//        //5秒种后发出唯一的一个元素0
//        let observable = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
//        observable.subscribe { event in
//            print(event)
//        }
        //延时5秒种后，每隔1秒钟发出一个元素
        let observable = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance)
        observable.subscribe { event in
            print(event)
        }
    }
    @IBAction func subscribeTestAction(_ sender: Any) {
        let observable = Observable.of("A", "B", "C")
        observable.subscribe { event in
            print(event)
            print(event.element)
        }
    }
    @IBAction func subscribe02TestAction(_ sender: Any) {
        let observable = Observable.of("A", "B", "C")
        
        observable.subscribe(onNext: { element in
            print(element)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        })
    }
    @IBAction func doOnTestAction(_ sender: Any) {
        let observable = Observable.of("A", "B", "C")
        
        observable
            .do(onNext: { element in
                print("Intercepted Next：", element)
            }, onError: { error in
                print("Intercepted Error：", error)
            }, onCompleted: {
                print("Intercepted Completed")
            }, onDispose: {
                print("Intercepted Disposed")
            })
            .subscribe(onNext: { element in
                print(element)
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            })
    }
    
    @IBAction func disposeTestAction(_ sender: Any) {
        let observable = Observable.of("A", "B", "C")
        
        //使用subscription常量存储这个订阅方法
        let subscription = observable.subscribe { event in
            print(event)
        }
        
        //调用这个订阅的dispose()方法
        subscription.dispose()
    }
    @IBAction func disposeBagTestAction(_ sender: Any) {
        let disposeBag = DisposeBag()
        
        //第1个Observable，及其订阅
        let observable1 = Observable.of("A", "B", "C")
        observable1.subscribe { event in
            print(event)
            }.disposed(by: disposeBag)
        
        //第2个Observable，及其订阅
        let observable2 = Observable.of(1, 2, 3)
        observable2.subscribe { event in
            print(event)
            }.disposed(by: disposeBag)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
