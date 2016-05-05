//
//  ViewController.swift
//  news1kenkou
//
//  Created by 城間大輔 on 2016/04/30.
//  Copyright © 2016年 daisuke shiroma. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sitesScrollView: UIScrollView!
    //ボタンを管理するための配列を定義
    var tabButtons:Array<UIButton> = []
    
    let wired = "WIRED"
    let shiki = "100SHIKI"
    let cinra = "CINRA.NET"
    
    let wiredImageName = "wired_top_image.png"
    let shikiImageName = "100shiki_top_image.png"
    let cinraImageName = "cinra_top_image.png"
    
    let blue = UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
    let yellow = UIColor(red: 105.0 / 255, green: 207.0 / 255, blue: 153.0 / 255, alpha: 1.0)
    let red = UIColor(red: 195.0 / 255, green: 123.0 / 255, blue: 175.0 / 255, alpha: 1.0)
    let black = UIColor(red: 50.0 / 255, green: 56.0 / 255, blue: 60.0 / 255, alpha: 1.0)
    //サイトURL
//    let wiredURL = ["http://kintore-channel.com/index.rdf",
//                    "http://blog.livedoor.jp/diet2channel/index.rdf"]
    let wiredArray : [String] = ["http://kintore-channel.com/index.rdf",
                                                 "http://blog.livedoor.jp/diet2channel/index.rdf"]
    let shikiArray : [String] =  ["http://blog.livedoor.jp/diet2channel/index.rdf,http://kintore-channel.com/index.rdf"]
    let cinraArray : [String] =   ["http://2chdiet.net/index.rdf,http://kintore-channel.com/index.rdf"]
//    var stringArray = ["http://blog.livedoor.jp/diet2channel/index.rdf,http://kintore-channel.com/index.rdf,http://2chdiet.net/index.rdf,http://kintore-channel.com/index.rdf"]
    //ボタンを生成
    func setTabButton(x: CGFloat, text: String, color: UIColor, tag: Int){
    var tabButton = UIButton()
        tabButton.frame.size = CGSizeMake(36, 36)
        tabButton.center = CGPointMake(x, 44)
        tabButton.setTitle(text, forState: UIControlState.Normal)
        tabButton.setTitleColor(color, forState: UIControlState.Selected)
        tabButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        tabButton.titleLabel?.font = UIFont(name: "HirakakuProN-W6", size: 13)
        tabButton.backgroundColor = black
        tabButton.tag = tag
        tabButton.addTarget(self, action: #selector(ArticleViewController.tapTabButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        tabButton.layer.cornerRadius = 18
        tabButton.layer.borderColor = UIColor.whiteColor().CGColor
        tabButton.layer.borderWidth = 1
        tabButton.layer.masksToBounds = true
        self.headerView.addSubview(tabButton)
        tabButtons.append(tabButton)
    }
    //タップしたボタンの動き
    func tapTabButton(sender: UIButton){
        let pointX = self.view.frame.width * CGFloat(sender.tag - 1)
        sitesScrollView.setContentOffset(CGPointMake(pointX, 0), animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sitesScrollView.delegate = self
        //sitesScrollView
        self.sitesScrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.sitesScrollView.frame.height)
        self.sitesScrollView.pagingEnabled = true
        //articleTableView
        setArticleTableView(0, siteName: wired, siteImageName: wiredImageName, color: blue, siteURLS: wiredArray)
        setArticleTableView(self.view.frame.width, siteName: shiki, siteImageName: shikiImageName, color: red, siteURLS: shikiArray)
        setArticleTableView(self.view.frame.width*2, siteName: cinra, siteImageName: cinraImageName, color: yellow, siteURLS: cinraArray)
        //ボタンの見た目
        setTabButton(self.view.center.x/2, text: "W", color: blue, tag: 1)
        setTabButton(self.view.center.x, text: "100", color: red, tag: 2)
        setTabButton(self.view.center.x*3/2, text: "C", color: yellow, tag: 3)
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //下記のものでもできる
//        //観覧中のページを取得(WIRED:page　== 0, 100SHKI: page == 1, CINRA: page == 2)
//        let page = scrollView.contentOffset.x / scrollView.frame.width
//        if page == 0 {
//            setSelectedButton(tabButtons[0], selected: true)
//            setSelectedButton(tabButtons[1], selected: false)
//            setSelectedButton(tabButtons[2], selected: false)
//        } else if page == 1 {
//            setSelectedButton(tabButtons[0], selected: false)
//            setSelectedButton(tabButtons[1], selected: true)
//            setSelectedButton(tabButtons[2], selected: false)
//        } else if page == 2 {
//            setSelectedButton(tabButtons[0], selected: false)
//            setSelectedButton(tabButtons[1], selected: false)
//            setSelectedButton(tabButtons[2], selected: true)
//        }
//    }
    //もしくは下記のものでもできる
//    //観覧中のページを取得(WIRED:page　=＝ 0, 100SHKI: page == 1, CINRA: page == 2)
//    let page = scrollView.contentOffset.x / scrollView.frame.width
//    
//    for num in 0..<3 {
//    if page == CGFloat(num) {
//    //閲覧中のページのみボタンを選択状態にする
//    setSelectedButton(tabButtons[num], selected: true)
//    } else {
//    //選択されていないボタンは選択状態を解除する
//    setSelectedButton(tabButtons[num], selected: false)
//    }
        //    } func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.width
        
        for num in 0..<3 {
            if page == CGFloat(num) {
                setSelectedButton(tabButtons[num], selected: true)
            } else {
                setSelectedButton(tabButtons[num], selected: false)
            }
        }
    }
    
    //ドラッグでのスクロールが終了時に呼ばれる
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.width
        
        for num in 0..<3 {
            if page == CGFloat(num) {
                setSelectedButton(tabButtons[num], selected: true)
            } else {
                setSelectedButton(tabButtons[num], selected: false)
            }
        }
    }
    
    func setSelectedButton(button: UIButton, selected: Bool) {
        button.selected = selected
        button.layer.borderColor = button.titleLabel?.textColor.CGColor
    }
    //ArticleTableViewを生成するためのメソッド
    func setArticleTableView(x: CGFloat, siteName: String, siteImageName: String, color: UIColor, siteURLS: [String]){
        let frame = CGRectMake(x, 0, self.view.frame.width, sitesScrollView.frame.height)
        let articleTableView = ArticleTableView(frame: frame, style: UITableViewStyle.Plain)
        articleTableView.loadRSS(siteURLS)
        articleTableView.siteName = siteName
        articleTableView.siteImageName = siteImageName
        articleTableView.color = color
        sitesScrollView.addSubview(articleTableView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

