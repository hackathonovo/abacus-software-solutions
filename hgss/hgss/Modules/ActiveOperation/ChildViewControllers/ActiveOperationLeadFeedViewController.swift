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
    
//    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let feeedContent: [FeedItem] = [
        FeedItem(updateTime: "12:00 12.02.2017", updateAuthor: "Mirko Mirić", updateContent: "Osoba pronadena negdje"),
        FeedItem(updateTime: "12:00 12.02.2017", updateAuthor: "Mirko Mirić", updateContent: "Osoba pronadena negdje"),
        FeedItem(updateTime: "12:00 12.02.2017", updateAuthor: "Mirko Mirić", updateContent: "Osoba pronadena negdje"),
        FeedItem(updateTime: "12:00 12.02.2017", updateAuthor: "Mirko Mirić", updateContent: "Osoba pronadena negdje"),
        FeedItem(updateTime: "12:00 12.02.2017", updateAuthor: "Mirko Mirić", updateContent: "Osoba pronadena negdje"),
        FeedItem(updateTime: "12:00 12.02.2017", updateAuthor: "Mirko Mirić", updateContent: "Osoba pronadena negdje")
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        print("asdasda")
        
        Alamofire.request("http://192.168.201.145:3000/api/mobile/feed/1").validate().responseJSON { response in
            print(response)
            if let json = response.result.value as? [String: Any]
            {
                let mlem: OperationUpdatesFeed = try! unbox(dictionary: json)
                
                print("\(mlem.feedUpdates.first?.author)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ActiveOperationLeadFeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OperationLeadFeedTableViewCell") as! OperationFeedTableViewCell
        
        cell.feedOperatorName.text = feeedContent[indexPath.row].updateAuthor
        cell.feedOperationUpdate.text = feeedContent[indexPath.row].updateTime
        cell.feedOperationUpdateContent.text = feeedContent[indexPath.row].updateContent
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feeedContent.count
    }
}
