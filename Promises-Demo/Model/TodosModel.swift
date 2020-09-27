//
//  TodosModel.swift
//  PromisesDemo
//
//  Created by Andrew on 8/21/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

struct Todo: Codable {
    let id: Int
    let title: String
    let completed: Bool
}
