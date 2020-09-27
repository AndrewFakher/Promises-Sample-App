//
//  ParallelPromises.swift
//  Promises-Demo
//
//  Created by Andrew on 8/29/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import PromiseKit

class ParallelPromises: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var todosTableView: UITableView!
    @IBOutlet weak var countriesTableView: UITableView!
    
    let networker = Networker()
    
    var countryList: [Country] = []
    var todoList: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countriesTableView.dataSource = self
        todosTableView.dataSource = self
        getAllTodosAndCountries()
    }
    
    // Parallel Promises /////////////////////////////
    func getAllTodosAndCountries(){
        firstly {
            when(fulfilled: networker.promiseFetchAllTodos(), networker.promiseFetchAllCountries())
        }
        .done { todoArray, countryArray in
            self.todoList = todoArray
            self.countryList = countryArray
            self.countriesTableView.reloadData()
            self.todosTableView.reloadData()
        }.ensure {
            self.activityIndicator.stopAnimating()
        }.catch { error in
                print("some kind of error listing all countries and todos -> \(error)")
        }
    }

}

extension ParallelPromises: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == todosTableView {
            return todoList.count
        }
        else {
            return countryList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countriesTableView.dequeueReusableCell(withIdentifier: "ParallelPromisesCell")!
        let cell2 = todosTableView.dequeueReusableCell(withIdentifier: "ParallelPromisesCell2")!

        if tableView == todosTableView{
            cell2.textLabel?.text = todoList[indexPath.row].title
            return cell2
        }
        else {
            cell.textLabel?.text = countryList[indexPath.row].name
            return cell
        }
    }
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == todosTableView {
            return "Todos List"
        }else {
            return "Countries List"
        }
    }
}
