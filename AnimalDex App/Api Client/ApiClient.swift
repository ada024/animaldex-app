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
    
    
    func getTrainers()  {
       
        guard let url = URL(string: "http://localhost:8080/trainers") else {
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
    
   
}
