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
   @ObservedObject var apiClient = ApiClient()

    var body: some View {
        NavigationView {
            List(self.apiClient.trainers, id: \.id) { trainer in
                NavigationLink(destination: TrainerDetailsView())
                {
                    VStack {
                        AsyncImage(
                            url:  URL(string: trainer.image)!,
                                       placeholder: { Text("Loading ...") },
                                       image: { Image(uiImage: $0).resizable() }
                                    )
                        .frame(idealHeight: UIScreen.main.bounds.width / 1.5)
                        Text(trainer.name)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .font(.system(size: 20))
                            .cornerRadius(10)
                    }
                }
            }
            
        .navigationBarTitle("Trainers")
            .navigationBarItems(trailing: Button(action: {
                self.isPresented = true
            }){
                Image(systemName: "plus")
            })
            .onAppear() {
                self.apiClient.getTrainers()
            }
            
            
        }.sheet(isPresented: $isPresented , onDismiss: {
            self.apiClient.getTrainers()
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
