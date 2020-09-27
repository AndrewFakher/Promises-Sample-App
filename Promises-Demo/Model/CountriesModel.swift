//
//  CountriesModel.swift
//  PromisesDemo
//
//  Created by Andrew on 8/20/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

struct Country: Codable {
    var name: String?
    var alpha2Code: String?
    var capital: String?
    var population: Int?
    var area: Double?
    var borders: [String]
    var currencies: [Currency]?
    var languages: [Language]?
}

struct Currency: Codable {
    var code: String?
    var name: String?
    var symbol: String?
}

struct Language: Codable {
    var name: String
}
