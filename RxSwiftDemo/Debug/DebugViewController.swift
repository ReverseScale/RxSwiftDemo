//
//  DebugViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/3/28.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DebugViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func debugAction(_ sender: Any) {
        createDebug()
    }
    @IBAction func debugTagAction(_ sender: Any) {
        createDebugTag()
    }
    @IBAction func resourcesTotalAction(_ sender: Any) {
        createResourcesTotal() 
    }
    
    func createDebug() {
        let disposeBag = DisposeBag()
        
        Observable.of("2", "3")
            .startWith("1")
            .debug()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func createDebugTag() {
        let disposeBag = DisposeBag()
        
        Observable.of("2", "3")
            .startWith("1")
            .debug("调试1")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func createResourcesTotal() {
        
//        print(RxSwift.Resources.total)
        
        let disposeBag = DisposeBag()
        
//        print(RxSwift.Resources.total)
        
        Observable.of("BBB", "CCC")
            .startWith("AAA")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
//        print(RxSwift.Resources.total)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
