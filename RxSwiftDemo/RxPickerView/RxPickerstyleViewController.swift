//
//  RxPickerstyleViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/12.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxPickerstyleViewController: UIViewController {
    var pickerView:UIPickerView!
    
    //设置文字属性的pickerView适配器
    private let attrStringPickerAdapter = RxPickerViewAttributedStringAdapter<[String]>(
        components: [],
        numberOfComponents: { _,_,_  in 1 },
        numberOfRowsInComponent: { (_, _, items, _) -> Int in
            return items.count}
    ){ (_, _, items, row, _) -> NSAttributedString? in
        return NSAttributedString(string: items[row],
                                  attributes: [
                                    NSAttributedStringKey.foregroundColor: UIColor.orange, //橙色文字
                                    NSAttributedStringKey.underlineStyle:
                                        NSUnderlineStyle.styleDouble.rawValue, //双下划线
                                    NSAttributedStringKey.textEffect:
                                        NSAttributedString.TextEffectStyle.letterpressStyle
            ])
    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RxPickerstyle"
        
        view.backgroundColor = UIColor.white
        
        //创建pickerView
        pickerView = UIPickerView()
        self.view.addSubview(pickerView)
        
        //绑定pickerView数据
        Observable.just(["One", "Two", "Tree"])
            .bind(to: pickerView.rx.items(adapter: attrStringPickerAdapter))
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
