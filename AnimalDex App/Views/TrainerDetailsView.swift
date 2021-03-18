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
    private func deleteTrainer() {
        ApiClient().deleteTrainer(trainer: trainer){ success in
            DispatchQueue.main.async {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func deleteAnimal(at offsets: IndexSet) {
        // preserve all ids to be deleted to avoid indices confusing
        let idsToDelete = offsets.map { self.apiClient.animals?[$0].id }
        // schedule remote delete for selected ids
        _ = idsToDelete.compactMap { id in
            ApiClient().deleteAnimal(uuid: id!){ success in
                if success {
                   DispatchQueue.main.async {
                    self.apiClient.animals?.removeAll { $0.id == id }
                   }
                }
            }
        }
    }
        
        
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
                        AnimalRow(animal: animal)
                    }.onDelete(perform: deleteAnimal)
                    
                }
            }.onAppear(perform: {
                self.apiClient.getAnimalsByTrainer(trainer: self.trainer)
            })
            .navigationBarTitle(trainer.name)
            .navigationBarItems(trailing: Button(action: {
                self.deleteTrainer()
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


