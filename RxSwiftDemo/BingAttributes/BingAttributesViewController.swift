//
//  BingAttributesViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/3/26.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BingAttributesViewController: UIViewController {

    @IBOutlet weak var labelBing: UILabel!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Observable序列（每隔0.5秒钟发出一个索引数）
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        observable
            .map { CGFloat($0) }
            .bind(to: labelBing.rx.fontSize) //根据索引数不断变放大字体
            .disposed(by: disposeBag)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
