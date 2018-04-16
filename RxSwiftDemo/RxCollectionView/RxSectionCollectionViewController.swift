//
//  RxSectionViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/11.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxSectionCollectionViewController: UIViewController {

    var collectionView:UICollectionView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RxSection"

        //定义布局方式以及单元格大小
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 70)
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 40)
        
        //创建集合视图
        self.collectionView = UICollectionView(frame: self.view.frame,
                                               collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.white
        
        //创建一个重用的单元格
        self.collectionView.register(RxCollectionCell.self,
                                     forCellWithReuseIdentifier: "Cell")
        //创建一个重用的分区头
        self.collectionView.register(RxCollectionHeaderCell.self,
                                     forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                     withReuseIdentifier: "Section")
        self.view.addSubview(self.collectionView!)
        
        
        //初始化数据
        let sections = Observable.just([
            MySectionSecc(header: "脚本语言", items: [
                "Python",
                "javascript",
                "PHP",
                ]),
            MySectionSecc(header: "高级语言", items: [
                "Swift",
                "C++",
                "Java",
                "C#"
                ])
            ])
        
        //创建数据源
        let dataSource = RxCollectionViewSectionedReloadDataSource<MySectionSecc>(
            configureCell: { (dataSource, collectionView, indexPath, element) in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                              for: indexPath) as! RxCollectionCell
                cell.label.text = "\(element)"
                return cell},
            configureSupplementaryView: {
                (ds ,cv, kind, ip) in
                let section = cv.dequeueReusableSupplementaryView(ofKind: kind,
                                                                  withReuseIdentifier: "Section", for: ip) as! RxCollectionHeaderCell
                section.label.text = "\(ds[ip.section].header)"
                return section
        })
        
        //绑定单元格数据
        sections
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//自定义Section
struct MySectionSecc {
    var header: String
    var items: [Item]
}

extension MySectionSecc : AnimatableSectionModelType {
    typealias Item = String
    
    var identity: String {
        return header
    }
    
    init(original: MySectionSecc, items: [Item]) {
        self = original
        self.items = items
    }
}
