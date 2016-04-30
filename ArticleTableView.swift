//
//  ArticleTableView.swift
//  news1kenkou
//
//  Created by 城間大輔 on 2016/04/30.
//  Copyright © 2016年 daisuke shiroma. All rights reserved.
//

import UIKit

class ArticleTableView: UITableView,UITableViewDelegate, UITableViewDataSource {
    //imageMaskViewの背景色
    let blue = UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
    //ソースコードでインスタンスを生成した場合
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        //プロトコル指定
        self.delegate = self
        self.dataSource = self
        self.registerNib(UINib(nibName: "SiteTopTableViewCell", bundle: nil), forCellReuseIdentifier: "SiteTopTableViewCell")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //セル数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //セル内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SiteTopTableViewCell", forIndexPath: indexPath) as! SiteTopTableViewCell
        cell.siteImageView.image = UIImage(named: "wired_top_image")
        cell.siteName.text = "WIRED"
        cell.imageMaskView.backgroundColor = blue
        return cell
    }
    //セルの高さ
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }

}
