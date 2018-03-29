//
//  RxCocoaTraitsViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/3/29.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxCocoaTraitsViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    let disposeBag = DisposeBag()
    
    //Single
    public enum SingleEvent<Element> {
        case success(Element)
        case error(Swift.Error)
    }
    
    //Maybe
    public enum MaybeEvent<Element> {
        case success(Element)
        case error(Swift.Error)
        case completed
    }
    
    //与缓存相关的错误类型
    enum CacheError: Error {
        case failedCaching
    }
    
    //与数据相关的错误类型
    enum DataError: Error {
        case cantParseJSON
    }
    
    //与缓存相关的错误类型
    enum StringError: Error {
        case failedGenerate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //将textField输入的文字绑定到label上
        textField.rx.text
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        //订阅按钮点击事件
        button.rx.tap
            .subscribe(onNext: {
                print("欢迎访问hangge.com")
            }).disposed(by: disposeBag)
        
    }
    @IBAction func MaybeAction(_ sender: Any) {
        createMaybe()
    }
    @IBAction func CompletableAction(_ sender: Any) {
        createCompletable()
    }
    @IBAction func SingleAction(_ sender: Any) {
        createSingle()
    }
    
    func createMaybe() {
        generateString()
            .subscribe(onSuccess: { element in
                print("执行完毕，并获得元素：\(element)")
            },
                       onError: { error in
                        print("执行失败: \(error.localizedDescription)")
            },
                       onCompleted: {
                        print("执行完毕，且没有任何元素。")
            })
            .disposed(by: disposeBag)
    }
    
    func createSingle() {
        //获取第0个频道的歌曲信息
        getPlaylist("0")
            .subscribe(onSuccess: { json in
                print("JSON结果: ", json)
            }, onError: { error in
                print("发生错误: ", error)
            })
            .disposed(by: disposeBag)
    }
    
    func createCompletable() {
        cacheLocally()
            .subscribe(onCompleted: {
                print("保存成功!")
            }, onError: { error in
                print("保存失败: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
    
    func generateString() -> Maybe<String> {
        return Maybe<String>.create { maybe in
            
            //成功并发出一个元素
            maybe(.success("hangge.com"))
            
            //成功但不发出任何元素
            maybe(.completed)
            
            //失败
            //maybe(.error(StringError.failedGenerate))
            
            return Disposables.create {}
        }
    }
    
    //获取豆瓣某频道下的歌曲信息
    func getPlaylist(_ channel: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create { single in
            let url = "https://douban.fm/j/mine/playlist?"
                + "type=n&channel=\(channel)&from=mainsite"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
                if let error = error {
                    single(.error(error))
                    return
                }
                
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data,
                                                                 options: .mutableLeaves),
                    let result = json as? [String: Any] else {
                        single(.error(DataError.cantParseJSON))
                        return
                }
                
                single(.success(result))
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
    
    //将数据缓存到本地
    func cacheLocally() -> Completable {
        return Completable.create { completable in
            //将数据缓存到本地（这里掠过具体的业务代码，随机成功或失败）
            let success = (arc4random() % 2 == 0)
            
            guard success else {
                completable(.error(CacheError.failedCaching))
                return Disposables.create {}
            }
            
            completable(.completed)
            return Disposables.create {}
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
extension Reactive where Base: UIButton {
    public var tap: ControlEvent<Void> {
        return controlEvent(.touchUpInside)
    }
}
