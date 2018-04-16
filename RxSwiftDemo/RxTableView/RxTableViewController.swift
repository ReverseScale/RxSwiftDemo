//
//  RxTableViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/4.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxTableViewController: UIViewController {

    var tableView:UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RxTable"

        createTableView()
        
        tableViewAction()
        
        deleteTableView()
        
        moveTableView()
        
        insetTableView()
        
        addIconOnLastLine()
        
        logAllTableAction()
    }
    
    func createTableView() {
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //初始化数据
        let items = Observable.just([
            "文本输入框的用法",
            "开关按钮的用法",
            "进度条的用法",
            "文本标签的用法",
            ])
        
        //设置单元格数据（其实就是对 cellForRowAt 的封装）
        items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(row)：\(element)"
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    func tableViewAction() {
        //获取选中项的索引
        tableView.rx.itemDeselected.subscribe({ [weak self] indexPath in
            print("被取消选中项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        //获取选中项的内容
        tableView.rx.modelSelected(String.self).subscribe({[weak self] item in
            print("选中项的标题为：\(item)")
        }).disposed(by: disposeBag)
        
        Observable.zip(tableView.rx.itemDeselected, tableView.rx.modelDeselected(String.self))
            .bind { [weak self] indexPath, item in
                print("zip-被取消选中项的indexPath为：\(indexPath)")
                print("zip-被取消选中项的的标题为：\(item)")
            }
            .disposed(by: disposeBag)
    }
    
    func deleteTableView() {
        //获取删除项的索引
        tableView.rx.itemDeleted.subscribe({ [weak self] indexPath in
            print("删除项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        //获取删除项的内容
        tableView.rx.modelDeleted(String.self).subscribe({[weak self] item in
            print("删除项的的标题为：\(item)")
        }).disposed(by: disposeBag)
    }
    
    func moveTableView() {
        //获取移动项的索引
        tableView.rx.itemMoved.subscribe(onNext: { [weak self]
            sourceIndexPath, destinationIndexPath in
            print("移动项原来的indexPath为：\(sourceIndexPath)")
            print("移动项现在的indexPath为：\(destinationIndexPath)")
        }).disposed(by: disposeBag)
    }
    
    func insetTableView(){
        //获取插入项的索引
        tableView.rx.itemInserted.subscribe({ [weak self] indexPath in
            print("插入项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
    }

    func addIconOnLastLine() {
        //获取点击的尾部图标的索引
        tableView.rx.itemAccessoryButtonTapped.subscribe({ [weak self] indexPath in
            print("尾部项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
    }
    
    func logAllTableAction() {
        //单元格将要显示出来的事件响应
        tableView.rx.willDisplayCell.subscribe(onNext: { cell, indexPath in
            print("将要显示单元格indexPath为：\(indexPath)")
            print("将要显示单元格cell为：\(cell)\n")
            
        }).disposed(by: disposeBag)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
