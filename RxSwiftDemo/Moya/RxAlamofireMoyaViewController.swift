//
//  RxAlamofireMoyaViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/17.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxAlamofireMoyaViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func moyaProvider() {
        //获取数据
        DouBanProvider.rx.request(.channels)
            .subscribe { event in
                switch event {
                case let .success(response):
                    //数据处理
                    let str = String(data: response.data, encoding: String.Encoding.utf8)
                    print("返回的数据是：", str ?? "")
                case let .error(error):
                    print("数据请求失败!错误原因：", error)
                }
            }.disposed(by: disposeBag)
    }
    @IBAction func moyaProviderOnErrorAction(_ sender: Any) {
        moyaProviderOnError()
    }
    @IBAction func moyaProviderAction(_ sender: Any) {
        moyaProvider()
    }
    
    func moyaProviderOnError() {
        //获取数据
        DouBanProvider.rx.request(.channels)
            .subscribe(onSuccess: { response in
                //数据处理
                let str = String(data: response.data, encoding: String.Encoding.utf8)
                print("返回的数据是：", str ?? "")
            },onError: { error in
                print("数据请求失败!错误原因：", error)
            }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
