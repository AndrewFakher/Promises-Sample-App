//
//  NetworkRequests.swift
//  PromisesDemo
//
//  Created by Andrew on 8/20/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import PromiseKit

let allCountriesURLString = "https://restcountries.eu/rest/v2/all"
let allTodosURLString = "https://jsonplaceholder.typicode.com/todos"

class Networker{
    // promise fetching using seal
    func promiseFetchAllCountries() -> Promise<[Country]> {
        let urlRequest = URLRequest(url: URL(string: allCountriesURLString)!)
        return Promise { seal in
            let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
                var countryArray: [Country] = []
                if let responseData = data {
                    do {
                        countryArray = try JSONDecoder().decode([Country].self, from: responseData)
                    } catch {
                        print("🗺 error trying to convert json: \(error)")
                    }
                    seal.fulfill(countryArray)
                } else if let requestError = error {
                    seal.reject(requestError)
                }
            }
            task.resume()
        }
    }
   
    /////////////////>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>/////////
    //promise fetching using PromiseKit Wrappers "Much cleaner than using seal"
    func promiseFetchAllCountries2() -> Promise<[Country]> {
        let urlRequest = URLRequest(url: URL(string: allCountriesURLString)!)
        return firstly {
          URLSession.shared.dataTask(.promise, with: urlRequest)
        }.compactMap {
          return try JSONDecoder().decode([Country].self, from: $0.data)
        }
    }

    func promiseFetchAllTodos() -> Promise<[Todo]> {
        let urlRequest = URLRequest(url: URL(string: allTodosURLString)!)
        return firstly {
          URLSession.shared.dataTask(.promise, with: urlRequest)
        }.compactMap {
          return try JSONDecoder().decode([Todo].self, from: $0.data)
        }
    }

    func promiseFetchFirstTodo(todoID: Int) -> Promise<Todo> {
        let urlRequest = URLRequest(url: URL(string: allTodosURLString + "/" + String(todoID))!)
        return firstly {
          URLSession.shared.dataTask(.promise, with: urlRequest)
        }.compactMap {
          return try JSONDecoder().decode(Todo.self, from: $0.data)
        }
        
    }

}
