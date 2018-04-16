//
//  RxCollectionChageViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/11.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxCollectionChageViewController: UIViewController {

    var collectionView:UICollectionView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RxChage"
        
        //定义布局方式
        let flowLayout = UICollectionViewFlowLayout()
        
        //创建集合视图
        self.collectionView = UICollectionView(frame: self.view.frame,
                                               collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.white
        
        //创建一个重用的单元格
        self.collectionView.register(RxCollectionCell.self,
                                     forCellWithReuseIdentifier: "Cell")
        self.view.addSubview(self.collectionView!)
        
        //初始化数据
        let items = Observable.just([
            SectionModel(model: "", items: [
                "Swift",
                "PHP",
                "Python",
                "Java",
                "C++",
                "C#"
                ])
            ])
        
        //创建数据源
        let dataSource = RxCollectionViewSectionedReloadDataSource
            <SectionModel<String, String>>(
                configureCell: { (dataSource, collectionView, indexPath, element) in
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                                  for: indexPath) as! RxCollectionCell
                    cell.label.text = "\(element)"
                    return cell}
        )
        
        //绑定单元格数据
        items
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        //设置代理
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//collectionView代理实现
extension RxCollectionChageViewController : UICollectionViewDelegateFlowLayout {
    //设置单元格尺寸
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 30) / 4 //每行显示4个单元格
        return CGSize(width: cellWidth, height: cellWidth * 1.5) //单元格宽度为高度1.5倍
    }
}
