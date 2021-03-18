//
//  AddTrainerView.swift
//  AnimalDex App
//
//  Created by Andreas M. (ada024) on 15/03/2021.
//

import SwiftUI

struct AddTrainerView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var name: String = ""
    @State private var image: String = ""
    
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func addTrainer () {
        
        ApiClient().addTrainer(name: self.name,image: self.image) { success in
            if success {
                self.presentationMode.wrappedValue.dismiss()
            } else {
                
            }
            
        }
        
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    VStack {
                        Image("placeholder").frame(maxWidth: 50, maxHeight: 50)
                    }.padding()
                    
                    TextField("Image URL", text: self.$image)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Name", text: self.$name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Save") {self.addTrainer() }
                        
                        .padding(8)
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .cornerRadius(8)
                    
                }.padding()
                .background(Color.white)
            }
            
            .navigationBarTitle("Add User")
            .navigationBarItems(trailing: Button("X") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddTrainerView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrainerView()
    }
}
