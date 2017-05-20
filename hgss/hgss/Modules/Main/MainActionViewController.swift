//
//  ViewController.swift
//  hgss
//
//  Created by Tin Jurkovic on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import UIKit

class MainActionViewController: UIViewController {

    @IBOutlet weak var btnCreateAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnCreateAction.layer.cornerRadius = btnCreateAction.frame.width / 2
        
    }



}

