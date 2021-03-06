//
//  CreateActionFromViewController.swift
//  hgss
//
//  Created by Tin Jurkovic on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import MapKit
import Alamofire

class CreateActionFormViewController : FormViewController, MKMapViewDelegate {
    
    var coordinates : CLLocationCoordinate2D?
    var selectedPeople:[SearchResponseModel] = []
    var rescueDesc: String = "Example Description"
    var leadId:Int = 3
    var kind:Int = 1
    
    
    @IBAction func create(_ sender: Any) {
        var idNums:[String] = []
        
        for i in selectedPeople {
            idNums.append("\(i.id)")
        }
        
        var idNumsStr = idNums.joined(separator:",")
        
        
        let parameters: Parameters = [
            "description":"\(rescueDesc)",
            "lead_id":"\(leadId)",
            "kind":"\(kind)",
            "start_position_latitude":"\(14)",
            "start_position_longitude":"\(15)",
            "rescuer_ids":"\(idNumsStr)",
        ]
        
        Alamofire.request("http://192.168.201.41:8000/api/mobile/rescue_actions", method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON {
            response in
            debugPrint(response)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //45.809354, 15.979938
        self.tableView?.contentInset.top = -35
        
        loadForm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("\(selectedPeople.count)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView?.reloadData()
    }
    
    func loadForm(){
        form +++ Section("")
            <<< LocationRow() { row in
                let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 44.858960, longitude: 16.486401), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
                
                row.cell.mapKitView.setRegion(region, animated: true)
                row.tag = "mapViewCell"
                
                row.cellUpdate { cell, row in
                    let locRow : LocationRow = row
                    
                    let locRowText : TextRow = self.form.rowBy(tag: "locationTextRow")!
                    
                    if(locRow.value?.coordinate != nil){
                        let latitude = locRow.value?.coordinate.latitude
                        let longitude = locRow.value?.coordinate.longitude
                        
                        let latitudeText = String(format: "%3f", latitude!)
                        let longitudeText = String(format: "%3f", longitude!)
                        locRowText.value = "\(latitudeText), \(longitudeText)"
                    } else {
                        locRowText.value = "Nepoznate kordinte"
                    }
                    
                    //print(textLocation)
                    
                }
                }.onChange{ [weak self] row in
                    self?.form.rowBy(tag: "locationTextRow")!.reload()
            }
            +++ Section("Detalji")
            <<< TextRow() { row in
                row.title = "Lokacija"
                row.tag = "locationTextRow"
            }
            <<< DateTimeRow() { row in
                row.title = "Početak"
                row.value = Date()
            }
            <<< TextRow() { row in
                row.title = "Voditelj"
                row.value = "Ivan Ivić"
                row.tag = "voditeljTextRow"
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Akcija"
                $0.selectorTitle = "Odaberite tip akcije"
                $0.options = ["Spašavanje","Potraga"]
                $0.value = "Spašavanje"    // initially selected
            }
            +++ Section("Opis")
            <<< TextAreaRow() { row in
                row.value = "Na Biokovu izgubljen planinar. Zadnji puta viđen prij 6h na križanju Prvog i Rakunovog puta."
                row.tag = "opisTextArea"
            }
            +++ Section("Tim")
            <<< ButtonRow { row in
                row.title = "Odaberi sudionike"
                }.onCellSelection({(cell, row) in
                    self.performSegue(withIdentifier: "SelectParticipantsSegue", sender: self)
                })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SelectParticipantsSegue") {
            (segue.destination as! CreateActionViewController).parentVC = self
        }
    }
    
    
}







