//
//  OperationFeedTableViewCell.swift
//  hgss
//
//  Created by Igor Mandić on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import UIKit

class OperationFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var feedOperatorName: UILabel!
    @IBOutlet weak var feedOperationUpdate: UILabel!
    @IBOutlet weak var feedOperationUpdateContent: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
