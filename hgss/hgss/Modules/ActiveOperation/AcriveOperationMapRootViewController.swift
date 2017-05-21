//
//  OperationMapViewController.swift
//  hgss
//
//  Created by Igor Mandić on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import UIKit
import Unbox
import Alamofire

class AcriveOperationMapViewController: UIViewController {

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
                
                
                
                
                
                
            }
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
