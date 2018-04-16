//
//  RxURLSessionHandelViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/13.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxURLSessionHandelViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RxURLHandel"

        testURLSessionHandel()
        testURLSessionMapHandel()
        testURLSessionRXJSONHandel()
    }
    
    func testURLSessionHandel() {
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //创建并发起请求
        URLSession.shared.rx.data(request: request).subscribe(onNext: {
            data in
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                as! [String: Any]
            print("--- 请求成功！返回的如下数据 ---")
            print(json!)
        }).disposed(by: disposeBag)
    }
    
    func testURLSessionMapHandel() {
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //创建并发起请求
        URLSession.shared.rx.data(request: request)
            .map {
                try JSONSerialization.jsonObject(with: $0, options: .allowFragments)
                    as! [String: Any]
            }
            .subscribe(onNext: {
                data in
                print("--- 请求成功！返回的如下数据 ---")
                print(data)
            }).disposed(by: disposeBag)
    }
    
    func testURLSessionRXJSONHandel() {
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //创建并发起请求
        URLSession.shared.rx.json(request: request).subscribe(onNext: {
            data in
            let json = data as! [String: Any]
            print("--- 请求成功！返回的如下数据 ---")
            print(json )
        }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
