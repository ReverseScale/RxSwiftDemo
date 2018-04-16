//
//  RxSwiftARCDemoViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/13.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftARCDemoViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RxARCDemo"
        
//        errorTest()
//        weakSelfTest()
        unownedSelfTest()
    }
    
    func errorTest() {
        textField.rx.text.orEmpty.asDriver().drive(onNext: {
            text in
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                print("当前输入内容：\(String(describing: text))")
                self.label.text = text
            }
        }).disposed(by: disposeBag)
    }
    
    func weakSelfTest() {
        textField.rx.text.orEmpty.asDriver().drive(onNext: {
            [weak self] text in
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                print("当前输入内容：\(String(describing: text))")
                self?.label.text = text
            }

        }).disposed(by: disposeBag)
    }
    
    func unownedSelfTest() {
        textField.rx.text.orEmpty.asDriver().drive(onNext: {
            [unowned self] text in
            print("当前输入内容：\(String(describing: text))")
            self.label.text = text
            
        }).disposed(by: disposeBag)
    }

    deinit {
        print(#file, #function)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
