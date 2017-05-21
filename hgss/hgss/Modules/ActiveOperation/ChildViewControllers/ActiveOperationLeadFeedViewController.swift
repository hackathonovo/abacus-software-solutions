//
//  ActiveOperationLeadFeedViewController.swift
//  hgss
//
//  Created by Igor Mandić on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import UIKit
import Alamofire
import Unbox

class ActiveOperationLeadFeedViewController: UIViewController {
    
    var feedItem: [SingleFeedUpdate]?
    
    @IBOutlet weak var textArea: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnFeed: UIButton!
    
    let feeedContent: [FeedItem] = [
        FeedItem(updateTime: "12:00 12.02.2017", updateAuthor: "Mirko Mirić", updateContent: "Osoba pronadena negdje"),
        FeedItem(updateTime: "12:00 12.02.2017", updateAuthor: "Mirko Mirić", updateContent: "Osoba pronadena negdje"),
        FeedItem(updateTime: "12:00 12.02.2017", updateAuthor: "Mirko Mirić", updateContent: "Osoba pronadena negdje"),
        FeedItem(updateTime: "12:00 12.02.2017", updateAuthor: "Mirko Mirić", updateContent: "Osoba pronadena negdje"),
        FeedItem(updateTime: "12:00 12.02.2017", updateAuthor: "Mirko Mirić", updateContent: "Osoba pronadena negdje"),
        FeedItem(updateTime: "12:00 12.02.2017", updateAuthor: "Mirko Mirić", updateContent: "Osoba pronadena negdje")
    ]
    
    @IBAction func btnPress(_ sender: Any) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        textArea.layer.cornerRadius = 5.0
        btnFeed.layer.cornerRadius = 5.0
        
        
        print("asdasda")
        
        Alamofire.request("http://192.168.201.145:3000/api/mobile/feed/1").validate().responseJSON { response in
            print(response)
            if let json = response.result.value as? [String: Any]
            {
                let feedasda:OperationUpdatesFeed = try! unbox(dictionary: json)
                
                self.feedItem = feedasda.feedUpdates
                
                print("\(self.feedItem?.first?.author)")
                
                self.tableView.dataSource = self
                self.tableView.delegate = self
                
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnPostFeed(_ sender: Any) {
        
    }
}


extension ActiveOperationLeadFeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OperationLeadFeedTableViewCell") as! OperationFeedTableViewCell
        
        let feed =  feedItem?[indexPath.row]
        
        cell.feedOperatorName.text = feed?.author
        cell.feedOperationUpdate.text = "\((feed?.createdAt)!)" ?? ""
        cell.feedOperationUpdateContent.text = feed?.text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feedItem?.count ?? 0
    }
}
