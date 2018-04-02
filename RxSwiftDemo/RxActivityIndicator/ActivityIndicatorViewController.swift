//
//  ActivityIndicatorViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/2.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ActivityIndicatorViewController: UIViewController {
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myButton: UIButton!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var segmented: UISegmentedControl!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSwitch()
        
        createSegmented()
        
        createSliderAndStepper()

    }
    func createSliderAndStepper() {
        slider.rx.value.asObservable()
            .subscribe(onNext: {
                print("当前值为：\($0)")
            })
            .disposed(by: disposeBag)
        
        stepper.rx.value.asObservable()
            .subscribe(onNext: {
                print("当前值为：\($0)")
            })
            .disposed(by: disposeBag)
        
        slider.rx.value
            .map{ Double($0) }  //由于slider值为Float类型，而stepper的stepValue为Double类型，因此需要转换
            .bind(to: stepper.rx.stepValue)
            .disposed(by: disposeBag)
        
    }
    func createSegmented() {
        //创建一个当前需要显示的图片的可观察序列
        let showImageObservable: Observable<UIImage> =
            segmented.rx.selectedSegmentIndex.asObservable().map {
                let images = ["js.png", "vue.png"]
                return UIImage(named: images[$0])!
        }
        
        //把需要显示的图片绑定到 imageView 上
        showImageObservable.bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
    
    func createSwitch() {
        // 直接输出
        mySwitch.rx.isOn.asObservable()
            .subscribe(onNext: {
                print("当前开关状态：\($0)")
            })
            .disposed(by: disposeBag)
        
        // 绑定自定义控件 activityIndicator 的状态
        mySwitch.rx.value
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        // 改变顶部状态栏上 Indicator 的状态
        mySwitch.rx.value
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        // 改变 myButton 状态
        mySwitch.rx.isOn
            .bind(to: myButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
