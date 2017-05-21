//
//  ViewController.swift
//  hgss
//
//  Created by Tin Jurkovic on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import UIKit
import Unbox
import Alamofire

class MainActionViewController: UIViewController {

    @IBOutlet weak var btnCreateAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnCreateAction.layer.cornerRadius = btnCreateAction.frame.width / 2
        
        var userId = 1
        
        Alamofire.request("http://192.168.201.41:8000/api/mobile/invites/for/\(userId)").responseJSON {
            response in
            if let json = response.result.value as? [String: Any]
            {
                let inviteResponse: InviteResponse = try! unbox(dictionary: json)
                
                
                
                var rescueId = -1
                var invId = -1
                for inv in inviteResponse.invites {
                    if (inv.rescueId > rescueId && inv.status == "unanswered") {
                        rescueId = inv.rescueId
                        invId = inv.id
                    }
                }
                
                if (rescueId > -1) {
                    self.showInvite(invId: rescueId, ii: invId)
                }
            }
        }
    }
    
    func showInvite(invId: Int, ii: Int) {
        let sb = UIStoryboard(name: "Invite", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "InviteViewController") as! UINavigationController
        
        let thevc = vc.childViewControllers.first as! InviteViewController
        
        thevc.rescueId = invId
        thevc.inviteId = ii
        
        self.present(vc, animated: false, completion: nil)
    }
}


struct InviteModel: Unboxable {
    let id:Int
    let rescueId: Int
    let status: String
    
    init(unboxer:Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.rescueId = try unboxer.unbox(key: "rescue_action_id")
        self.status = try unboxer.unbox(key: "status")
    }
}

struct InviteResponse: Unboxable {
    let invites:[InviteModel]
    
    init(unboxer:Unboxer) throws {
        self.invites = try unboxer.unbox(key: "data")
    }
}
