//
//  TrainerDetailsView.swift
//  AnimalDex App
//
//  Created by Andreas M. (ada024) on 15/03/2021.
//

import SwiftUI

struct TrainerDetailsView: View {
    
    let trainer: Trainer

    @ObservedObject private var apiClient = ApiClient()
    
    @Environment(\.presentationMode) private var presentationMode
    
    
    // deleteTrainer

    

    var body: some View {
        Form {
            AsyncImage(
                url:  URL(string: trainer.image)!,
                           placeholder: { Text("Loading ...") },
                           image: { Image(uiImage: $0).resizable() }
                        )
                .aspectRatio(contentMode: .fit)
                .padding()
            Section(header: Text("ANIMALS").fontWeight(.bold)) {
                ForEach(self.apiClient.animals ?? [Animal](), id: \.id) { animal in
                    Text(animal.name)
                }
    
            }
        }.onAppear(perform: {
            self.apiClient.getAnimalsByTrainer(trainer: self.trainer)
        })
        .navigationBarTitle(trainer.name)
        .navigationBarItems(trailing: Button(action: {
            //deleteTrainer
        }) {
            Image(systemName: "trash.fill")
        })
    }
    
}

struct TrainerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerDetailsView(trainer: Trainer( name: "Neo", image: "https://via.placeholder.com/200x350"))
    }
}


