//
//  RxOperatorViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/3.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxOperatorViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    var userVM = UserViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
//        handelOperator()
        
        handelRx()
    }
    
    func handelOperator() {
        //将用户名与textField做双向绑定
        userVM.username.asObservable().bind(to: textField.rx.text).disposed(by: disposeBag)
        textField.rx.text.orEmpty.bind(to: userVM.username).disposed(by: disposeBag)
        
        //将用户信息绑定到label上
        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)
    }
    
    func handelRx() {
        //将用户名与textField做双向绑定
        _ =  self.textField.rx.textInput <->  self.userVM.username
        
        //将用户信息绑定到label上
        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
