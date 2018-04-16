//
//  RxCocoaUITextFileViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/3/30.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxCocoaUITextFileViewController: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textView: UITextView!

    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cocoa UITextFile"

        andString()
        
        listen()
    }
    
    func andString() {
        Observable.combineLatest(textField1.rx.text.orEmpty, textField2.rx.text.orEmpty) {
            textValue1, textValue2 -> String in
            return "你输入的号码是：\(textValue1)-\(textValue2)"
            }
            .map { $0 }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        //在用户名输入框中按下 return 键
        textField1.rx.controlEvent(.editingDidEndOnExit).subscribe({
            [weak self] (_) in
            self?.textField1.becomeFirstResponder()
        }).disposed(by: disposeBag)
        
        //在密码输入框中按下 return 键
        textField2.rx.controlEvent(.editingDidEndOnExit).subscribe({
            [weak self] (_) in
            self?.textField1.resignFirstResponder()
        }).disposed(by: disposeBag)
    }
    
    func listen() {
        //开始编辑响应
        textView.rx.didBeginEditing
            .subscribe(onNext: {
                print("开始编辑")
            })
            .disposed(by: disposeBag)
        
        //结束编辑响应
        textView.rx.didEndEditing
            .subscribe(onNext: {
                print("结束编辑")
            })
            .disposed(by: disposeBag)
        
        //内容发生变化响应
        textView.rx.didChange
            .subscribe(onNext: {
                print("内容发生改变")
            })
            .disposed(by: disposeBag)
        
        //选中部分变化响应
        textView.rx.didChangeSelection
            .subscribe(onNext: {
                print("选中部分发生变化")
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
