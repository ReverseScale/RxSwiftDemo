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
            ["Music 列表演示","RxMusic 列表演示"],
            ["RxSwift 基本语法"],
            ["RxSwift Bind"],
        ]
        titleDic = [
            "Music 列表演示":"传统实现方式",
            "RxMusic 列表演示":"响应式编程，减少了 1/4 代码量",
            "RxSwift 基本语法":"Observable订阅、监听、销毁",
            "RxSwift Bind":"将索引数Bind到Label",
        ]
        picDic = [
            "Music 列表演示":"",
            "RxMusic 列表演示":"",
            "RxSwift 基本语法":"",
            "RxSwift Bind":"",
        ]
        naviControl = [
            "Music 列表演示":"PastTableViewController",
            "RxMusic 列表演示":"FutureTableViewController",
            "RxSwift 基本语法":"GrammarsViewController",
            "RxSwift Bind":"AddIndexViewController",
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
