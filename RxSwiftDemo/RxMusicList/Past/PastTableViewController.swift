//
//  PastTableViewController.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/3/23.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit
import RxSwift

class PastTableViewController: UIViewController {
    
    //tableView对象
    @IBOutlet weak var tableView: UITableView!
    
    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Music 列表"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "musicCell")

        //设置代理
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PastTableViewController:UITableViewDataSource {
    //返回单元格数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicListViewModel.data.count
    }
    
    //返回对应的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell")!
            let music = musicListViewModel.data[indexPath.row]
            cell.textLabel?.text = music.name
            cell.detailTextLabel?.text = music.singer
            return cell
    }
}
extension PastTableViewController: UITableViewDelegate {
    //单元格点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("你选中的歌曲信息【\(musicListViewModel.data[indexPath.row])】")
    }
}
