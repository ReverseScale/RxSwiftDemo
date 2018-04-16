//
//  RxAlamofireUploadViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/16.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire

class RxAlamofireUploadViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        alamofireUpload()
    }
    
    func alamofireUpload() {
        //需要上传的文件路径
        let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")
        //服务器路径
        let uploadURL = URL(string: "http://www.hangge.com/upload.php")!
        
        //将文件上传到服务器
        upload(fileURL!, urlRequest: try! urlRequest(.post, uploadURL))
            .subscribe(onNext: { element in
                print("--- 开始上传 ---")
                element.uploadProgress(closure: { (progress) in
                    print("当前进度：\(progress.fractionCompleted)")
                    print("  已上传载：\(progress.completedUnitCount/1024)KB")
                    print("  总大小：\(progress.totalUnitCount/1024)KB")
                })
            }, onError: { error in
                print("上传失败! 失败原因：\(error)")
            }, onCompleted: {
                print("上传完毕!")
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
