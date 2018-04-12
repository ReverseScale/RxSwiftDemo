//
//  RxPickerViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/12.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxPickerViewController: UIViewController {

    var pickerView:UIPickerView!
    
    //最简单的pickerView适配器（显示普通文本）
    private let stringPickerAdapter = RxPickerViewStringAdapter<[[String]]>(
        components: [],
        numberOfComponents: { dataSource,pickerView,components  in components.count },
        numberOfRowsInComponent: { (_, _, components, component) -> Int in
            return components[component].count},
        titleForRow: { (_, _, components, row, component) -> String? in
            return components[component][row]}
    )
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        //创建pickerView
        pickerView = UIPickerView()
        self.view.addSubview(pickerView)

        //绑定pickerView数据
        Observable.just([["One", "Two", "Tree"],
                         ["A", "B", "C", "D"]])
            .bind(to: pickerView.rx.items(adapter: stringPickerAdapter))
            .disposed(by: disposeBag)
        
    
        //建立一个按钮，触摸按钮时获得选择框被选择的索引
        let button = UIButton(frame:CGRect(x:0, y:0, width:100, height:30))
        button.center = self.view.center
        button.backgroundColor = UIColor.blue
        button.setTitle("获取信息",for:.normal)
        //按钮点击响应
        button.rx.tap
            .bind { [weak self] in
                self?.getPickerViewValue()
            }
            .disposed(by: disposeBag)
        self.view.addSubview(button)
    }
    
    //触摸按钮时，获得被选中的索引
    @objc func getPickerViewValue(){
        let message = String(pickerView.selectedRow(inComponent: 0)) + "-"
            + String(pickerView!.selectedRow(inComponent: 1))
        let alertController = UIAlertController(title: "被选中的索引为",
                                                message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
