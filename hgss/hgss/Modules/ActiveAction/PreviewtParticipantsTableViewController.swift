//
//  PreviewtParticipantsTableViewController.swift
//  hgss
//
//  Created by Tin Jurkovic on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import Foundation
import UIKit

class Sudionik{
    var name : String
    var surname : String
    var mobileNum : String
    
    init(name : String, surname : String, mobileNum : String) {
        self.name = name
        self.surname = surname
        self.mobileNum = mobileNum
    }
    
    func getFullName() -> String {
        return self.name + " " + self.surname
    }
}


class PreviewtParticipantsTableViewController : UITableViewController {
    
    var testList : [Sudionik] = [Sudionik]()
    
    override func viewDidLoad() {
        testList.append(Sudionik(name: "Ivan", surname: "Ivic", mobileNum: "+385 91 1234 321"))
        testList.append(Sudionik(name: "Darian", surname: "Jug", mobileNum: "+385 91 2223 452"))
        testList.append(Sudionik(name: "Igor", surname: "Mandic", mobileNum: "+385 91 9254 319"))
        
        
        super.viewDidLoad()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantCell", for: indexPath) as! ParticipantTableViewCell
        
        let participant = testList[indexPath.row]
        
        cell.fullName.text = participant.getFullName()
        cell.mobileNum = participant.mobileNum
        
        
        return cell
    }
    
    
}
