//
//  ConnectableViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/3/27.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ConnectableViewController: UIViewController {
    
    @IBOutlet weak var connectableLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Connectable"

        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .share(replay: 5)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: {
                print("订阅1: \($0)")
                self.connectableLabel.text = String($0)
            })
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: {
                    print("订阅2: \($0)")
                    self.connectableLabel.text = String($0)
                })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    ///延迟执行
    /// - Parameters:
    ///   - delay: 延迟时间（秒）
    ///   - closure: 延迟执行的闭包
    public func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }

}
