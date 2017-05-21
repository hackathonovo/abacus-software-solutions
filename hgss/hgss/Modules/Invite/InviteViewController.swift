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
    var inviteId:Int?
    
    var childVC:InviteFormViewController?
    
    @IBAction func odbaci(_ sender: Any) {
        let parameters: Parameters = ["status":"\(2)"]
        Alamofire.request("http://192.168.201.41:8000/api/mobile/invites/\(inviteId!)", method: .post, parameters: parameters, encoding: URLEncoding.default)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func prihvati(_ sender: Any) {
        let parameters: Parameters = ["status":"\(1)"]
        Alamofire.request("http://192.168.201.41:8000/api/mobile/invites/\(inviteId!)", method: .post, parameters: parameters, encoding: URLEncoding.default)
        
        performSegue(withIdentifier: "ActiveOperationStoryboardSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EmbeddedInviteVC") {
            childVC = segue.destination as! InviteFormViewController
            childVC?.operationId = rescueId
        }
        
        if (segue.identifier == "ActiveOperationStoryboardSegue") {
            let opDetVC = segue.destination as! ActiveOperationTabBarViewController
            opDetVC.operationId = rescueId
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
