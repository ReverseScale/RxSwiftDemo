//
//  DatePickerViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/3.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var label: UILabel!
    
    //日期格式化器
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
        return formatter
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        datePicker.rx.date
            .map { [weak self] in
                "当前选择时间: " + self!.dateFormatter.string(from: $0)
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
