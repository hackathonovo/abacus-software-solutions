//
//  ActiveActionFormViewController.swift
//  hgss
//
//  Created by Tin Jurkovic on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import Foundation
import Eureka
import MapKit

class ActiveActionFormViewController : FormViewController {
    
    override func viewDidLoad() {
        
        self.tableView?.contentInset.top = -35
        
        self.loadForm()
        
        super.viewDidLoad()
    }
    
    
    func loadForm(){
        form +++ Section("")
            <<< LocationRow() { row in
                let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 44.858960, longitude: 16.486401), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
                
                row.cell.mapKitView.setRegion(region, animated: true)
                row.tag = "mapViewCell"
                
            }
            +++ Section("Detalji")
            <<< TextRow() { row in
                row.title = "Lokacija"
                row.tag = "locationTextRow"
                row.disabled = true
            }
            <<< DateTimeRow() { row in
                row.title = "Početak"
                row.value = Date()
                row.disabled = true
            }
            <<< TextRow() { row in
                row.title = "Voditelj"
                row.value = "Ivan Ivić"
                row.tag = "voditeljTextRow"
                row.disabled = true
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Akcija"
                $0.selectorTitle = "Odaberite tip akcije"
                $0.options = ["Spašavanje","Potraga"]
                $0.value = "Spašavanje"    // initially selected
                $0.disabled = true
            }
            +++ Section("Opis")
            <<< TextAreaRow() { row in
                row.value = "Na Biokovu izgubljen planinar. Zadnji puta viđen prije 6h na križanju Prvog i Rakunovog puta."
                row.tag = "opisTextArea"
                row.disabled = true
            }
            +++ Section("Tim")
            <<< ButtonRow { row in
                row.title = "Prikaži sudionike"
                }.onCellSelection({(cell, row) in
                    self.performSegue(withIdentifier: "PreviewtParticipantsSegue", sender: self)
                })
    }

}
