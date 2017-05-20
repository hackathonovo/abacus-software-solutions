//
//  ParticipantTableViewCell.swift
//  hgss
//
//  Created by Tin Jurkovic on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import Foundation
import UIKit

class ParticipantTableViewCell : UITableViewCell {
    
    @IBOutlet weak var fullName: UILabel!
    
    var mobileNum : String!
    
    @IBAction func callParticipant(_ sender: Any) {
        if let callURL = URL(string: "tel://\(mobileNum)"), UIApplication.shared.canOpenURL(callURL) {
            UIApplication.shared.openURL(callURL)
        }
    }
}
