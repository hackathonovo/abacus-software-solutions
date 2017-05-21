//
//  InviteViewController.swift
//  hgss
//
//  Created by Igor Mandić on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import UIKit
import Alamofire

class InviteViewController: UIViewController {
    
    var rescueId:Int?
    var childVC:InviteFormViewController?

    @IBOutlet weak var childVCContainer: UIView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EmbeddedInviteVC") {
            childVC = segue.destination as! InviteFormViewController
            childVC?.operationId = rescueId
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
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
