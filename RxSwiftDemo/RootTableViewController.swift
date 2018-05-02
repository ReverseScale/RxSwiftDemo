//
//  RootTableViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/3/23.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit

class RootTableViewController: UIViewController {
    
    var arrayList = NSArray()
    var titleDic = NSDictionary()
    var picDic = NSDictionary()
    var naviControl = NSDictionary()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        //创建表视图
        tableView.delegate = self
        tableView.dataSource = self
        //创建一个重用的单元格
        tableView.register(IntroductionModuleTableCell.self , forCellReuseIdentifier: "cell")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()

    func createData() {
        arrayList = [
            ["Music 列表演示",
             "RxMusic 列表演示"],
            ["RxSwift 基本语法"],
            ["RxSwift Bind",
             "Bing Attributes"],
            ["Subjects"],
            ["Transforming",
             "ConditionalBoolean",
             "Combining",
             "MathematicalAggregate"],
            ["Connectable"],
            ["ErrorHandling",
             "Debug"],
            ["RxCocoaTraits",
             "RxCocoaUI",
             "RxCocoaUITextFile",
             "RxCocoaUIButton",
             "RxActivityIndicator"],
            ["RxOperator",
             "RxGestureRecognizer",
             "DatePicker",
             "TimeDatePicker"],
            ["RxTableView",
             "RxCustomTableView",
             "RxDataTableView",
             "RxSearchTableView",
             "RxEditTableView",
//             "RxDiffTableView",
             "RxSecTableView",
            ],
            ["RxCollectionView",
             "RxSectionCollectionView",
             "RxCollectionUpdateView",
             "RxCollectionChageView",
            ],
            ["RxPickerView",
             "RxPickerstyleView",
            ],
            ["RxSwiftARCAbout",
             "RxURLSession",
             "RxURLSessionHandel",
             "RxSessionTable",
             "RxSessionModel",
            ],
            ["RxAlamofire",
             "RxAlamofireUpload",
             "RxAlamofireDownload",
            ],
            ["RxAlamofireMoya",
             "RxAlamofireMoyaHandle",
            ],
            ["RxMVVM",
            ],
        ]
        titleDic = [
            "Music 列表演示":"传统实现方式",
            "RxMusic 列表演示":"响应式编程，减少了 1/4 代码量",
            "RxSwift 基本语法":"Observable订阅、监听、销毁",
            "RxSwift Bind":"将索引数Bind到Label",
            "Bing Attributes":"对 Reactive 扩展绑定",
            "Subjects":"Subjects 基本介绍",
            "Transforming":"变换操作示例",
            "ConditionalBoolean":"条件和布尔操作符",
            "Combining":"结合操作示例",
            "MathematicalAggregate":"算数、以及聚合操作",
            "Connectable":"连接操作",
            "ErrorHandling":"错误处理",
            "Debug":"调试操作",
            "RxCocoaTraits":"RxCocoa traits",
            "RxCocoaUI":"RxCocoa UI",
            "RxCocoaUITextFile":"RxCocoa UI TextFile",
            "RxCocoaUIButton":"RxCocoa UI Button",
            "RxActivityIndicator":"活动指示器",
            "RxOperator":"双向绑定操作",
            "RxGestureRecognizer":"手势识别封装",
            "DatePicker":"时间选择器",
            "TimeDatePicker":"倒计时使用",
            "RxTableView":"列表使用",
            "RxCustomTableView":"自定义列表使用",
            "RxDataTableView":"列表数据刷新",
            "RxSearchTableView":"搜索列表",
            "RxEditTableView":"编辑表格",
            "RxDiffTableView":"不同样式表格",
            "RxSecTableView":"自定义表头列表",
            "RxCollectionView":"卡片布局",
            "RxSectionCollectionView":"标题头卡片布局",
            "RxCollectionUpdateView":"带更新的卡片布局",
            "RxCollectionChageView":"变化的卡片布局",
            "RxPickerView":"选项卡",
            "RxPickerstyleView":"自定义样式选项卡",
            "RxSwiftARCAbout":"ARC 下循环引用示例",
            "RxURLSession":"Rx 的 URLSession",
            "RxURLSessionHandel":"Rx 的 URLSession 处理",
            "RxSessionTable":"RxURLSession 请求列表",
            "RxSessionModel":"RxSession 映射",
            "RxAlamofire":"RxAlamofire 使用",
            "RxAlamofireUpload":"RxAlamofire 上传",
            "RxAlamofireDownload":"RxAlamofire 下载",
            "RxAlamofireMoya":"结合 Moya 演示",
            "RxAlamofireMoyaHandle":"Moya 处理",
            "RxMVVM":"MVVM 层级",
        ]
        picDic = [
            "Music 列表演示":"",
            "RxMusic 列表演示":"",
            "RxSwift 基本语法":"",
            "RxSwift Bind":"",
            "Bing Attributes":"",
            "Subjects":"",
            "Transforming":"",
            "ConditionalBoolean":"",
            "Combining":"",
            "MathematicalAggregate":"",
            "Connectable":"",
            "ErrorHandling":"",
            "Debug":"",
            "RxCocoaTraits":"",
            "RxCocoaUI":"",
            "RxCocoaUITextFile":"",
            "RxCocoaUIButton":"",
            "RxActivityIndicator":"",
            "RxOperator":"",
            "RxGestureRecognizer":"",
            "DatePicker":"",
            "TimeDatePicker":"",
            "RxTableView":"",
            "RxCustomTableView":"",
            "RxDataTableView":"",
            "RxSearchTableView":"",
            "RxEditTableView":"",
            "RxDiffTableView":"",
            "RxSecTableView":"",
            "RxCollectionView":"",
            "RxSectionCollectionView":"",
            "RxCollectionUpdateView":"",
            "RxCollectionChageView":"",
            "RxPickerView":"",
            "RxPickerstyleView":"",
            "RxSwiftARCAbout":"",
            "RxURLSession":"",
            "RxURLSessionHandel":"",
            "RxSessionTable":"",
            "RxSessionModel":"",
            "RxAlamofire":"",
            "RxAlamofireUpload":"",
            "RxAlamofireDownload":"",
            "RxAlamofireMoya":"",
            "RxAlamofireMoyaHandle":"",
            "RxMVVM":"",
        ]
        naviControl = [
            "Music 列表演示":"PastTableViewController",
            "RxMusic 列表演示":"FutureTableViewController",
            "RxSwift 基本语法":"GrammarsViewController",
            "RxSwift Bind":"AddIndexViewController",
            "Bing Attributes":"BingAttributesViewController",
            "Subjects":"SubjectsViewController",
            "Transforming":"TransformingViewController",
            "ConditionalBoolean":"ConditionalBooleanViewController",
            "Combining":"CombiningObservablesViewController",
            "MathematicalAggregate":"MathematicalAggregateViewController",
            "Connectable":"ConnectableViewController",
            "ErrorHandling":"ErrorHandlingViewController",
            "Debug":"DebugViewController",
            "Driver":"DriverViewController",
            "RxCocoaTraits":"RxCocoaTraitsViewController",
            "RxCocoaUI":"RxCocoaUIViewController",
            "RxCocoaUITextFile":"RxCocoaUITextFileViewController",
            "RxCocoaUIButton":"RxCocoaUIButtonViewController",
            "RxActivityIndicator":"ActivityIndicatorViewController",
            "RxOperator":"RxOperatorViewController",
            "RxGestureRecognizer":"GestureRecognizerViewController",
            "DatePicker":"DatePickerViewController",
            "TimeDatePicker":"TimeDatePickerViewController",
            "RxTableView":"RxTableViewController",
            "RxCustomTableView":"RxCustomTableViewController",
            "RxDataTableView":"RxDataTableViewController",
            "RxSearchTableView":"RxSearchTableViewController",
            "RxEditTableView":"RxEditTableViewController",
            "RxDiffTableView":"RxDiffTableViewController",
            "RxSecTableView":"RxSecTableViewController",
            "RxCollectionView":"RxCollectionViewController",
            "RxSectionCollectionView":"RxSectionCollectionViewController",
            "RxCollectionUpdateView":"RxCollectionUpdateViewController",
            "RxCollectionChageView":"RxCollectionChageViewController",
            "RxPickerView":"RxPickerViewController",
            "RxPickerstyleView":"RxPickerstyleViewController",
            "RxSwiftARCAbout":"RxSwiftARCDemoViewController",
            "RxURLSession":"RxURLSessionViewController",
            "RxURLSessionHandel":"RxURLSessionHandelViewController",
            "RxSessionTable":"RxSessionTableViewController",
            "RxSessionModel":"RxSessionModelViewController",
            "RxAlamofire":"RxAlamofireViewController",
            "RxAlamofireUpload":"RxAlamofireUploadViewController",
            "RxAlamofireDownload":"RxAlamofireDownloadViewController",
            "RxAlamofireMoya":"RxAlamofireMoyaViewController",
            "RxAlamofireMoyaHandle":"RxAlamofireMoyaHandleViewController",
            "RxMVVM":"RxMVVMViewController",
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RxSwift 演示"
        
        view.addSubview(tableView)
        
        createData()
        
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide)
                make.left.right.equalTo(self.view)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                make.size.equalTo(self.view)
                make.center.equalTo(self.view)
            }
        }
        super.updateViewConstraints()
    }
    
    func openDetailView(type:String) {
        let vc:UIViewController = (NSClassFromString("RxSwiftDemo."+type) as! UIViewController.Type).init()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension RootTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrayList[section] as AnyObject).count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell") as! IntroductionModuleTableCell
        cell.selectionStyle = .none
        
        let titleKey = (arrayList[indexPath.section] as! NSArray)
        let tky = titleKey[indexPath.row]
        
        cell.labelTitle.text = tky as? String
//        cell.imagePhone.image = UIImage(named: self.picDic[tky] as! String)
        cell.labelContronter.text = self.titleDic[tky] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let titleKey = (arrayList[indexPath.section] as! NSArray)
        let tky = titleKey[indexPath.row]
        openDetailView(type:(naviControl[tky] as? String)!)
    }
}
