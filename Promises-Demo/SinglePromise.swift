//
//  ViewController.swift
//  PromisesDemo
//
//  Created by Andrew on 8/16/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit

class SinglePromise: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    let networker = Networker()
    
    var countryList: [Country] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        getAllCountries()
    }
    
    
    // Single Promise ////////
    func getAllCountries(){
        networker.promiseFetchAllCountries2().done{ countryArray in
            self.countryList = countryArray
            self.tableView.reloadData()
        }.ensure {
            self.activityIndicator.stopAnimating()
        }.catch{ error in
            print("some kind of error getting countries -> \(error)")
        }
    }
}

extension SinglePromise: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell")!
        cell.textLabel?.text = countryList[indexPath.row].name
        return cell
    }

}
