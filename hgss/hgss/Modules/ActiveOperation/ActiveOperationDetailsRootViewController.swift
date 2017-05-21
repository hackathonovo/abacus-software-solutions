//
//  OperationDetailsViewController.swift
//  hgss
//
//  Created by Igor Mandić on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import UIKit
import Eureka
import Alamofire
import Unbox
import CoreLocation

class ActiveOperationDetailsRootViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let tabbarRoot = self.tabBarController as! ActiveOperationTabBarViewController
        
        let url = URL(string: "http://192.168.201.41:8000/api/mobile/detail/\(tabbarRoot.operationId!)")
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
                            if let url = NSURL(string: "tel://\(m.phoneNumber)") {
                                UIApplication.shared.openURL(url as URL)
                            }
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
