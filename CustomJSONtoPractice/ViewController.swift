//
//  ViewController.swift
//  CustomJSONtoPractice
//
//  Created by EthanLin on 2018/1/8.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewCellButtonTapped {
    
    //實作自己定義的protocol
    func buttonBeTapped(index: IndexPath) {                                   /*因為index已經被存成tableView的indexPath，看下面的方法cellForRowAt*/
        performSegue(withIdentifier: "connectWebSegue", sender: websitesData?.websites[index.row].webAddress)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "connectWebSegue"{
            if let webView = segue.destination as? WebViewController{
                if let webURL = sender as? String{
                    webView.webAddressFromTableView = webURL
                }
                
            }
        }
    }
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRows = websitesData?.websites.count{
            return numberOfRows
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.cellLabel.text = websitesData?.websites[indexPath.row].title
        //小心不要漏掉下面這兩行，會無法實現delegate(TableViewCellButtonTapped)
        //把tableView中的indexPath存進cell中的index屬性．這步很重要
        cell.index = indexPath
        cell.delegate = self
        
        // 圖片部份的處理
        if let imageAddress = websitesData?.websites[indexPath.row].image{
            if let imageURL = URL(string: imageAddress){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL)
                    if let downloadedImageData = data{
                        let downloadedImage = UIImage(data: downloadedImageData)
                        DispatchQueue.main.async {
                            cell.cellImageView.image = downloadedImage
                        }
                    }
                }
            }
        }
        return cell
    }
    
    
    
    @IBOutlet weak var myTableview: UITableView!
    
    
    //創建一個型別為JSONData的屬性
    var websitesData:JSONData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadedJSON()
        myTableview.delegate = self
        myTableview.dataSource = self
        
        //處理圖片的部分
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    //把demo.json先假裝是網路上抓下來的
    func downloadedJSON(){
        if let url = Bundle.main.url(forResource: "demo", withExtension:"json"){
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil{
                    print("something is wrong")
                    return
                }
                if let downloadedData = data{
                    do{
                        let decoder = JSONDecoder()
                        let downloadedWebsites = try decoder.decode(JSONData.self, from: downloadedData)
                        print(downloadedWebsites.websites.count)
                        //                        print(downloadedWebsites.websites[0].image)
                        print(downloadedWebsites.websites[0].title)
                        self.websitesData = downloadedWebsites
                        
                        DispatchQueue.main.async {
                            self.myTableview.reloadData()
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            })
            task.resume()
        }
    }
}

