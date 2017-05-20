//
//  InviteViewController.swift
//  hgss
//
//  Created by Igor Mandić on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import UIKit
import Eureka

class InviteFormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Lokacija")
            <<< LocationRow { row in
                row.title = ""
        }
        +++ Section("Detalji")
            <<< TextRow() { row in
                row.title = "Početna Lokacija"
                row.value = "Gorski Kotar"
        }
            <<< TextRow() { row in
                row.title = "Početak"
                row.value = "02.03.2017 13:55"
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
