//
//  ArticleTableView.swift
//  news1kenkou
//
//  Created by 城間大輔 on 2016/04/30.
//  Copyright © 2016年 daisuke shiroma. All rights reserved.
//

import UIKit

//extension Array {
//    func shuffled() -> [Element] {
//        var list = self
//        for i in 0..<(list.count - 1) {
//            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
//            swap(&list[i], &list[j])
//        }
//        return list
//    }
//}


class ArticleTableView: UITableView,UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate {
    //imageMaskViewの背景色
//    let blue = UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
    var siteName: String!
    var siteImageName: String!
    var color: UIColor!
    var elementName = ""
    var articles:Array<Article> = []
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
            return self.articles.count
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
            self.articles.sortInPlace({ $0.date > $1.date })
            let article = self.articles[indexPath.row]
            cell.title.text = article.title
            cell.descript.text = article.descript
            cell.date.text = article.date
            cell.date.text = conversionDateFormat(article.date)
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
    func loadRSS(siteURLS: [String]) {
        for siteURL in siteURLS {
        if let url = NSURL(string: siteURL) {
            let request = NSURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: {
                (data, response, error) -> Void in
                let parser = NSXMLParser(data: data!)
                parser.delegate = self
                parser.parse()
                })
            task.resume()
        }
        }
    }
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        self.elementName = elementName
        if self.elementName == "item" {
            let article = Article()
            self.articles.append(article)
        }
    }
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        let lastArticle = self.articles.last
        if self.elementName == "title" {
            lastArticle?.title += string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        } else if self.elementName == "description" {
            lastArticle?.descript += string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        } else if self.elementName == "dc:date" {
            lastArticle?.date += string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        } else if self.elementName == "link" {
            lastArticle?.link += string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
    }
    func parserDidEndDocument(parser: NSXMLParser) {
        dispatch_async(dispatch_get_main_queue(), {
            self.reloadData()
        })
    }
    func conversionDateFormat(dateString:String) -> String {
        let inputFormatter = NSDateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date: NSDate! = inputFormatter.dateFromString(dateString)
//        2016-05-04T12:00:23+09:00
        let outputFormatter = NSDateFormatter()
        outputFormatter.dateFormat = "yyy/MM/dd HH:mm"
        let outputDateString = outputFormatter.stringFromDate(date)
        return outputDateString
    }
}
