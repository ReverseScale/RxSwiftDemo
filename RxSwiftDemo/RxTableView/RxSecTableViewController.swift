//
//  RxSecTableViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/10.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxSecTableViewController: UIViewController {

    var tableView:UITableView!
    
    var dataSource:RxTableViewSectionedAnimatedDataSource<MySectionSec>?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //初始化数据
        let sections = Observable.just([
            MySectionSec(header: "基本控件", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
                ]),
            MySectionSec(header: "高级控件", items: [
                "UITableView的用法",
                "UICollectionViews的用法"
                ])
            ])
        
        //创建数据源
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySectionSec>(
            //设置单元格
            configureCell: { ds, tv, ip, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")
                    ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
                cell.textLabel?.text = "\(ip.row)：\(item)"
                
                return cell
        },
            //设置分区尾部标题
            titleForFooterInSection: { ds, index in
                return "共有\(ds.sectionModels[index].items.count)个控件"
        }
        )
        
        self.dataSource = dataSource
        
        //绑定单元格数据
        sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        //设置代理
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//tableView代理实现
extension RxSecTableViewController : UITableViewDelegate {
    //返回分区头部视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int)
        -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.black
            let titleLabel = UILabel()
            titleLabel.text = self.dataSource?[section].header
            titleLabel.textColor = UIColor.white
            titleLabel.sizeToFit()
            titleLabel.center = CGPoint(x: self.view.frame.width/2, y: 20)
            headerView.addSubview(titleLabel)
            return headerView
    }
    
    //返回分区头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int)
        -> CGFloat {
            return 40
    }
}

//自定义Section
struct MySectionSec {
    var header: String
    var items: [Item]
}

extension MySectionSec : AnimatableSectionModelType {
    typealias Item = String
    
    var identity: String {
        return header
    }
    
    init(original: MySectionSec, items: [Item]) {
        self = original
        self.items = items
    }
}
