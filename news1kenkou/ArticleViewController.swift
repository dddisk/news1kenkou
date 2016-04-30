//
//  ViewController.swift
//  news1kenkou
//
//  Created by 城間大輔 on 2016/04/30.
//  Copyright © 2016年 daisuke shiroma. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sitesScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //sitesScrollView
        self.sitesScrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.sitesScrollView.frame.height)
        self.sitesScrollView.pagingEnabled = true
        //ArticleTableViewのインスタンスを生成
        setArticleTableView(0)
        setArticleTableView(self.view.frame.width)
        setArticleTableView(self.view.frame.width*2)
    }
    
    //ArticleTableViewを生成するためのメソッド
    func setArticleTableView(x: CGFloat){
        let frame = CGRectMake(x, 0, self.view.frame.width, sitesScrollView.frame.height)
        let articleTableView = ArticleTableView(frame: frame, style: UITableViewStyle.Plain)
        self.sitesScrollView.addSubview(articleTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

