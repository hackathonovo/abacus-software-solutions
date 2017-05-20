//
//  ActiveOperationFeedTableViewController.swift
//  hgss
//
//  Created by Igor Mandić on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import UIKit

class ActiveOperationFeedTableViewController: UITableViewController {
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OperationFeedTableViewCell") as! OperationFeedTableViewCell
        
        cell.feedOperatorName.text = feeedContent[indexPath.row].updateAuthor
        cell.feedOperationUpdate.text = feeedContent[indexPath.row].updateTime
        cell.feedOperationUpdateContent.text = feeedContent[indexPath.row].updateContent
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feeedContent.count
    }
}


struct FeedItem {
    var updateTime: String
    var updateAuthor: String
    var updateContent: String
    
    init(updateTime: String, updateAuthor: String, updateContent: String) {
        self.updateTime = updateTime
        self.updateAuthor = updateAuthor
        self.updateContent = updateContent
    }
}
