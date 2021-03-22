//
//  ContentView.swift
//  AnimalDex App
//
//  Created by Andreas M. (ada024) on 15/03/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    @Environment(\.presentationMode) var presentationMode
    let screenSize = UIScreen.main.bounds
   // @ObservedObject var apiClient = ApiClient()
    @State var trainers: [Trainer] = []
    
    
    var body: some View {
        NavigationView {
            List(trainers, id: \.id) { trainer in
          //      List( id: \.id) { trainer in
                NavigationLink(destination: TrainerDetailsView(trainer: trainer))
                {
                    VStack(alignment: .leading) {
                        AsyncImage(
                            url:  URL(string: trainer.image)!,
                            placeholder: { Text("Loading ...") },
                            image: { Image(uiImage: $0).resizable() }
                        )
                        .frame(width: 155, height: 155).cornerRadius(5)
                        Text(trainer.name)
                            .font(.headline)
                            .padding(.leading, 15)
                            .padding(.top, 5)
                    }.padding(.leading, 15)
                }
            }
            
            .navigationBarTitle("Trainers")
            .navigationBarItems(trailing: Button(action: {
                self.isPresented = true
            }){
                Image(systemName: "plus")
            })
            .onAppear() {
                ApiClient().getTrainers { [self] (result: Result<[Trainer], Error>) in
                    switch result {
                    case .success(let trainers):
                        self.trainers = trainers
                    case .failure(let error):
                      print("error getting trainings \(error)")
                    }
                    
                  //  self.trainers = trainers
                }
             //   self.apiClient.getTrainers()
            }
            
            
        }.sheet(isPresented: $isPresented , onDismiss: {
            ApiClient().getTrainers { [self] (result: Result<[Trainer], Error>) in
                switch result {
                case .success(let trainers):
                    self.trainers = trainers
                case .failure(let error):
                  print("error getting trainings \(error)")
                }
                
              //  self.trainers = trainers
            }
            
            
            
            
          //  self.apiClient.getTrainers()
        }, content: {
            AddTrainerView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
