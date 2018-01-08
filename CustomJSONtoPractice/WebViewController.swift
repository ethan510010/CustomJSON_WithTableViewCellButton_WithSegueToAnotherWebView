//
//  WebViewController.swift
//  CustomJSONtoPractice
//
//  Created by EthanLin on 2018/1/8.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
//從前面tableView傳過來的資料
    var webAddressFromTableView:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //先訂出範圍
        let wkWebViewRange = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        //實體化一個WKWebView
        let webView = UIWebView(frame: wkWebViewRange)
//        let webView = WKWebView(frame: wkWebViewRange)
        //加到畫面上
        self.view.addSubview(webView)
        
        if let url = URL(string:webAddressFromTableView!){
            let myRequest = URLRequest(url: url)
            webView.loadRequest(myRequest)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
