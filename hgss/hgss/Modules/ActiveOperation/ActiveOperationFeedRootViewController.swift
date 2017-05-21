//
//  OperationFeedViewController.swift
//  hgss
//
//  Created by Igor Mandić on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import UIKit

class ActiveOperationFeedRootViewController: UIViewController {
    
    @IBOutlet weak var feedChildViewController: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = storyboard!.instantiateViewController(withIdentifier: "ActiveOperationLeadFeedViewController") as! ActiveOperationLeadFeedViewController
        addChildViewController(controller)
        //controller.view.translatesAutoresizingMaskIntoConstraints = false
        feedChildViewController.addSubview(controller.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
