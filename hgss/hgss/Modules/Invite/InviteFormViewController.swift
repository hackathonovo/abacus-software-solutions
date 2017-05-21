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
import Foundation
import CoreLocation

class InviteFormViewController: FormViewController {
    
    var operationId:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://192.168.201.41:8000/api/mobile/detail/\(operationId!)")
        let urlRequest = NSMutableURLRequest(url: url!)
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        
        Alamofire.request(urlRequest as URLRequest).validate().responseJSON { response in
            print(response)
            if let json = response.result.value as? [String: Any]
            {
                let root: OperationModelRoot = try! unbox(dictionary: json)
                let sect = Section("Tim")
                for m in root.data.teamMembers {
                    sect <<< LabelRow() { row in
                        row.title = "\(m.name)"
                        row.onCellSelection({(cell, row) in
                            row.onCellSelection({(cell, row) in
                                if let url = NSURL(string: "tel://\(m.phoneNumber)") {
                                    UIApplication.shared.openURL(url as URL)
                                }
                            })
                        })
                    }
                }
                self.form +++ Section("Lokacija")
                    <<< LocationRow { row in
                        row.title = ""
                        row.cell.isUserInteractionEnabled = false
                        row.value = CLLocation(latitude: Double(root.data.location.latitude), longitude: Double(root.data.location.longitude))
                    }
                    +++ Section("Detalji")
                    <<< LabelRow() { row in
                        row.title = "Početna Lokacija"
                        row.value = "\(root.data.location.latitude),\(root.data.location.longitude)"
                    }
                    <<< LabelRow() { row in
                        row.title = "Početak"
                        row.value = "\(NSDate(timeIntervalSince1970: TimeInterval(root.data.startTime)))"
                    }
                    <<< LabelRow() { row in
                        row.title = "Voditelj"
                        row.value = "\(root.data.leader.name)"
                        row.onCellSelection({(cell, row) in
                            print("\(root.data.leader.phoneNumber)")
                        })
                    }
                    <<< LabelRow() { row in
                        row.title = "Tip"
                        row.value = "Potraga"
                    }
                    +++ Section("Opis")
                    <<< LabelRow() { row in
                        row.title = "Opis"
                        row.value = "\(root.data.description)"
                    }
                    +++ sect

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
    let data:OperationModel
    
    init(unboxer: Unboxer) throws {
        self.data = try unboxer.unbox(key: "data")
    }
}
