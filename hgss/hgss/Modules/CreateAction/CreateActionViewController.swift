//
//  CreateActionViewController.swift
//  hgss
//
//  Created by Igor Mandić on 21/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import UIKit
import Alamofire
import Unbox

class CreateActionViewController: UITableViewController, UISearchBarDelegate {
    
    var parentVC:CreateActionFormViewController? = nil
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func done(_ sender: Any) {
        parentVC!.selectedPeople.append(contentsOf: selectedPeople)
        navigationController?.popViewController(animated: true)
    }
    
    var selectedLatitude:Float?
    var selectedLongitude:Float?
    
    var searchResultPeople: [SearchResponseModel]? = []

    
    var selectedPeople:[SearchResponseModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        
        selectedLatitude = 45
        selectedLongitude = 15
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let parameters: Parameters = [
            "longitude":"\(selectedLongitude!)",
            "latitude":"\(selectedLatitude!)"]
        
        Alamofire.request("http://192.168.201.145:3000/api/mobile/rescuers/\(searchText)", parameters: parameters, encoding: URLEncoding.default).responseJSON {
            response in
            if let json = response.result.value as? [String: Any]
            {
                let searchResponse: SearchResponseModelRoot = try! unbox(dictionary: json)
                
                self.searchResultPeople = searchResponse.data
                
                self.tableView.dataSource = self
                self.tableView.delegate = self
                self.tableView.reloadData()
            }
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchResultPeople?.count)!
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellItem = tableView.dequeueReusableCell(withIdentifier: "CreateActionViewControllerCell") as! CreateActionViewControllerCell
        
        cellItem.userName.text = self.searchResultPeople![indexPath.row].name
        
        cellItem.distance.text = self.searchResultPeople![indexPath.row].distance
        
        return cellItem
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ( tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            for i in 0..<selectedPeople.count {
                if (selectedPeople[i].id == self.searchResultPeople![indexPath.row].id) {
                    selectedPeople.remove(at: i)
                }
            }
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            selectedPeople.append(searchResultPeople![indexPath.row])
        }
        
        print(selectedPeople.count)
    }
    
}



struct SearchResponseModel: Unboxable {
    let id:Int
    let name:String
    let phoneNumber: String
    let distance: String
    
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key:"name")
        self.phoneNumber = try unboxer.unbox(key:"phone_number")
        self.distance = try unboxer.unbox(key:"distance")
    }
}

struct SearchResponseModelRoot: Unboxable {
    let data: [SearchResponseModel]
    
    init(unboxer: Unboxer) throws {
        self.data = try unboxer.unbox(key: "data")
    }
}

class CreateActionViewControllerCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var distance: UILabel!
    
}
