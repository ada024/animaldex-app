//
//  ApiClient.swift
//  AnimalDex App
//
//  Created by Andreas M. (ada024) on 15/03/2021.
//

import Foundation

class ApiClient: ObservableObject {
    
    @Published var trainers: [Trainer] = [Trainer]()
    @Published var animals: [Animal]? = [Animal]()
    
    
    
    func deleteTrainer(trainer: Trainer, completion: @escaping (Bool) -> Void)  {
           guard let uuid = trainer.id,
           let url = URL(string: "http://localhost:8080/trainers/api/\(uuid.uuidString)") else {
               fatalError("URL is not defined!")
           }
           var request = URLRequest(url: url)
           request.httpMethod = "DELETE"
           URLSession.shared.dataTask(with: request) { data, _, error in
               guard let _ = data, error == nil else {
                   return completion(false)
               }
               completion(true)
           }.resume()
       }
    
    
    func getTrainers()  {
        guard let url = URL(string: "http://localhost:8080/trainers/api") else {
            fatalError("URL is not defined!")
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let trainers = try? JSONDecoder().decode([Trainer].self, from: data)
            if let trainers = trainers {
                DispatchQueue.main.async {
                    self.trainers = trainers
                }
            }
        }.resume()
    }
    
    func getAnimalsByTrainer(trainer: Trainer) {
        guard let uuid = trainer.id,
        let url = URL(string: "http://localhost:8080/trainers/api/\(uuid.uuidString)/animals") else {
            fatalError("URL is not defined!")
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
           let decAnimals = try? JSONDecoder().decode([Animal].self, from: data)
            if let decAnimals = decAnimals {
                DispatchQueue.main.async {
                    self.animals = decAnimals
                }
            }
        }.resume()
    }
}
