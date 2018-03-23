//
//  AddIndexViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/3/23.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddIndexViewController: UIViewController {

    @IBOutlet weak var addIndexLabel: UILabel!
    
    @IBOutlet weak var anyObserverAddIndexLabel: UILabel!
    
    @IBOutlet weak var binderAddIndexLabel: UILabel!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        observableTest()
        
        anyObserver()
        
        binderObserver()
        
    }
    func observableTest() {
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        observable
            .map { "bind 当前索引数：\($0 )"}
            .bind { [weak self](text) in
                //收到发出的索引数后显示到label上
                self?.addIndexLabel.text = text
            }
            .disposed(by: disposeBag)
    }

    func anyObserver() {
        //观察者
        let observer: AnyObserver<String> = AnyObserver { [weak self] (event) in
            switch event {
            case .next(let text):
                //收到发出的索引数后显示到label上
                self?.anyObserverAddIndexLabel.text = text
            default:
                break
            }
        }
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map { "bindTo 当前索引数：\($0 )"}
            .bind(to: observer)
            .disposed(by: disposeBag)
    }
    
    func binderObserver() {
        //观察者
        let observer: Binder<String> = Binder(binderAddIndexLabel) { (view, text) in
            //收到发出的索引数后显示到label上
            view.text = text
        }
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map { "binder 当前索引数：\($0 )"}
            .bind(to: observer)
            .disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
