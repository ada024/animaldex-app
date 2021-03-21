//
//  ApiClient.swift
//  AnimalDex App
//
//  Created by Andreas M. (ada024) on 15/03/2021.
//

import Foundation

class ApiClient: ObservableObject {
    private let baseURL = "localhost"
    @Published var trainers: [Trainer] = [Trainer]()
    @Published var animals: [Animal]? = [Animal]()
    
    func addTrainer(name: String,image: String, completion: @escaping (Bool) -> Void)  {
        let components =  composeURLComponent(path: "/trainers")
        guard let composedURL = components.url else {print("URL creating failed");return}
        var request = URLRequest(url: composedURL)
        let trainer = Trainer(name: name, image: image)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(trainer)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            
            completion(true)
            
        }.resume()
    }
    
    
    func deleteTrainer(trainer: Trainer, completion: @escaping (Bool) -> Void)  {
        guard let uuid = trainer.id else {fatalError("Missing uid!")}
        let components =  composeURLComponent(path: "/trainers/\(uuid.uuidString)")
        guard let composedURL = components.url else {print("URL creating failed");return}
        var request = URLRequest(url: composedURL)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, res, error in
            if let httpRes = res as? HTTPURLResponse {
                print("Status Code: \(httpRes.statusCode)")
                
                if httpRes.statusCode == 200 {
                    completion(true)
                }else {
                    completion(false)
                }
            }
            //            guard let _ = data, error == nil else {return completion(false)}
            //            completion(true)
        }.resume()
    }
    
    
    func getTrainers()  {
        let components =  composeURLComponent(path: "/api/trainers")
        guard let composedURL = components.url else {print("URL is not defined!");return}
        URLSession.shared.dataTask(with: composedURL) { data, response, error in
            guard let data = data, error == nil else {fatalError("URL format is wrong!")}
            let trainers = try? JSONDecoder().decode([Trainer].self, from: data)
            if let trainers = trainers {
                DispatchQueue.main.async {
                    self.trainers = trainers
                }
            }
        }.resume()
        
    }
    
    func getAnimalsByTrainer(trainer: Trainer) {
        guard let uuid = trainer.id else {fatalError("Missing uid!")}
        let components =  composeURLComponent(path: "/api/trainers/\(uuid.uuidString)/animals")
        guard let composedURL = components.url else {print("URL is not defined!");return}
        URLSession.shared.dataTask(with: composedURL) { data, _, error in
            guard let data = data, error == nil else {
                print("Some error \(String(describing: error))")
                return
            }
            let decAnimals = try? JSONDecoder().decode([Animal].self, from: data)
            if let decAnimals = decAnimals {
                print(decAnimals)
                DispatchQueue.main.async {
                    self.animals = decAnimals
                }
            }
        }.resume()
    }
    
    func deleteAnimal(uuid: UUID, completion: @escaping (Bool) -> Void) {
        let components =  composeURLComponent(path: "/animals/delete/\(uuid.uuidString)/animals")
        guard let composedURL = components.url else {print("URL creating failed");return}
        var request = URLRequest(url: composedURL)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
    
    func composeURLComponent(path: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = baseURL
        components.port = 8080
        components.path = path
        return components
    }
}
