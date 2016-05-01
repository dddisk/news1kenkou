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
//    let blue = UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
    var siteName: String!
    var siteImageName: String!
    var color: UIColor!
    //ソースコードでインスタンスを生成した場合
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        //プロトコル指定
        self.delegate = self
        self.dataSource = self
        self.registerNib(UINib(nibName: "SiteTopTableViewCell", bundle: nil), forCellReuseIdentifier: "SiteTopTableViewCell")
        self.registerNib(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    //セル数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    //セルの内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("SiteTopTableViewCell", forIndexPath: indexPath) as! SiteTopTableViewCell
//            cell.siteImageView.image = UIImage(named: "wired_top_image")
//            cell.siteName.text = "WIRED"
//            cell.imageMaskView.backgroundColor = blue
            cell.siteImageView.image = UIImage(named: self.siteImageName)
            cell.siteName.text = self.siteName
            cell.imageMaskView.backgroundColor = self.color
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ArticleTableViewCell", forIndexPath: indexPath) as! ArticleTableViewCell
            return cell
       }
       }
    //セルの高さ
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else {
            return 85
        }
        }
    //urlの読み込み
    func loadRSS(siteURL: String) {
        if let url = NSURL(string: siteURL) {
            let request = NSURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: {
                (data, response, error) -> Void in
                print(data)
                })
            task.resume()
        }
    }
}
