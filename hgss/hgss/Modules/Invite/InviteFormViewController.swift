//
//  InviteViewController.swift
//  hgss
//
//  Created by Igor Mandić on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import UIKit
import Eureka
import Alamofire
import Unbox

class InviteFormViewController: FormViewController {
    
    var operationId:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://192.168.201.145:3000/api/mobile/feed/\(operationId)").validate().responseJSON { response in
            print(response)
            if let json = response.result.value as? [String: Any]
            {
                let root: OperationModelRoot = try! unbox(dictionary: json)
                
                form +++ Section("Lokacija")
                    <<< LocationRow { row in
                        row.title = ""
                    }
                    +++ Section("Detalji")
                    <<< TextRow() { row in
                        row.title = "Početna Lokacija"
                        row.value = "\(root.location.latitude),\(root.location.longitude)"
                    }
                    <<< TextRow() { row in
                        row.title = "Početak"
                        row.value = "\(NSDate(timeIntervalSince1970: root.startTime))"
                    }
                    <<< TextRow() { row in
                        row.title = "Voditelj"
                        row.value = "Ivo Ivica"
                    }
                    <<< TextRow() { row in
                        row.title = "Tip"
                        row.value = "Potraga"
                    }
                    +++ Section("Opis")
                    <<< TextAreaRow() { row in
                        row.title = "Opis"
                        row.value = "Netko se je izgubio i treba biti spašen"
                    }
                    +++ Section("Tim")
                    <<< TextRow() { row in
                        row.title = "Neko Nekić"
                    }
                    <<< TextRow() { row in
                        row.title = "Neko Nekić"
                    }
                    <<< TextRow() { row in
                        row.title = "Neko Nekić"
                }

            }
        }
        
                for row in form.rows {
            row.baseCell.isUserInteractionEnabled = false
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

struct OperationLocationModel:Unboxable {
    let latitude: Float
    let longitude: Float
    
    init(unboxer:Unboxer) throws {
        self.latitude = try unboxer.unbox(key: "latitude")
        self.longitude = try unboxer.unbox(key: "longitude")
    }
}

struct OperationLeaderModel:Unboxable {
    let name:String
    let phoneNumber:String
    
    init(unboxer:Unboxer) throws {
        self.name = try unboxer.unbox(key: "name")
        self.phoneNumber = try unboxer.unbox(key: "phone_number")
    }
}

struct OperationTeamMemberModel:Unboxable {
    let id:Int
    let name:String
    let phoneNumber:String
    let status:String
    
    init(unboxer:Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
        self.phoneNumber = try unboxer.unbox(key: "phone_number")
        self.status = try unboxer.unbox(key: "status")
    }
}

struct OperationModel:Unboxable {
    let id:Int
    let location:OperationLocationModel
    let leader:OperationLeaderModel
    let teamMembers:[OperationTeamMemberModel]
    let startTime:Int
    let description:String
    
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.location = try unboxer.unbox(key: "location")
        self.leader = try unboxer.unbox(key: "leader")
        self.teamMembers = try unboxer.unbox(key: "team_members")
        self.startTime = try unboxer.unbox(key: "start_time")
        self.description = try unboxer.unbox(key: "description")
    }
}

struct OperationModelRoot:Unboxable {
    let id:Int
    let location:OperationLocationModel
    let leader:OperationLeaderModel
    let teamMembers:[OperationTeamMemberModel]
    let startTime:Int
    let description:String
    
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.location = try unboxer.unbox(key: "location")
        self.leader = try unboxer.unbox(key: "leader")
        self.teamMembers = try unboxer.unbox(key: "team_members")
        self.startTime = try unboxer.unbox(key: "start_time")
        self.description = try unboxer.unbox(key: "description")
    }
}
