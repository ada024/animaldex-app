//
//  Trainer.swift
//  AnimalDex App
//
//  Created by Andreas M. (ada024) on 15/03/2021.
//

import Foundation

struct Trainer: Codable {
    var id: UUID?
    var name: String
    var image: String
    
    private enum TrainerKeys: String, CodingKey {
        case id
        case name
        case image
    }
}


extension Trainer {
    init(from decoder: Decoder)  throws {
        let container = try decoder.container(keyedBy: TrainerKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
    }
}
