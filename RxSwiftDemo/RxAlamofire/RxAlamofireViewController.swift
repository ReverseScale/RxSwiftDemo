//
//  RxAlamofireViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/13.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire
class RxAlamofireViewController: UIViewController {

    //“发起请求”按钮
    @IBOutlet weak var startBtn: UIButton!
    
    //“取消请求”按钮
    @IBOutlet weak var cancelBtn: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RxAlamofire"
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        //发起请求按钮点击
        startBtn.rx.tap.asObservable()
            .flatMap {_ in
                request(.get, url).responseString()
                    .takeUntil(self.cancelBtn.rx.tap) //如果“取消按钮”点击则停止请求
            }
            .subscribe(onNext: {
                response, data in
                print("请求成功！返回的数据是：", data)
            }, onError: { error in
                print("请求失败！错误原因：", error)
            }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
