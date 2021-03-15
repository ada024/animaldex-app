//
//  Animal.swift
//  AnimalDex App
//
//  Created by Andreas M. (ada024) on 15/03/2021.
//

import Foundation

struct Animal: Codable {
    var id: UUID?
    var name: String
    var description: String?
    var image: String?
    var type: String?
    var trainer: Trainer?
}
