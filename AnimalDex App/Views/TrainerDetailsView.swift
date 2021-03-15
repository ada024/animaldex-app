//
//  TrainerDetailsView.swift
//  AnimalDex App
//
//  Created by Andreas M. (ada024) on 15/03/2021.
//

import SwiftUI

struct TrainerDetailsView: View {
    /*
    let user: User
    
    @State private var reviewTitle: String = ""
    @State private var reviewBody: String = ""
    
    @ObservedObject private var httpClient = HTTPUserClient()
    
    @Environment(\.presentationMode) private var presentationMode
    
    
    
    private func deleteUser() {
        HTTPUserClient().deleteUser(user: user){ success in
            
            DispatchQueue.main.async {
                self.presentationMode.wrappedValue.dismiss()
            }
            
        }
    }
    
    private func saveReview() {
        let review = Review(subject: self.reviewTitle, body: self.reviewBody, user: user)
        HTTPUserClient().saveReview(review: review) { success in // ignoring the return value-bool, denoted with _
            if success {
                self.httpClient.getReviewsByUser(user: self.user)
            }
        }
    }
    */
    var body: some View {
        Text("Dummy")
        /*
        Form {
            
            Image(user.poster)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Section(header: Text("ADD A REVIEW").fontWeight(.bold)) {
                VStack(alignment: .center, spacing: 10) {
                    TextField("Enter Title",text: $reviewTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Enter Body",text: $reviewBody) .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Save") {
                        self.saveReview()
                    }
                }
                
            }
            
            Section(header: Text("REVIEWS").fontWeight(.bold)) {
              
                ForEach(self.httpClient.reviews ?? [Review](), id: \.id) { review in
                    Text(review.subject)
                    
                }
    
            }
        }.onAppear(perform: {
            self.httpClient.getReviewsByUser(user: self.user)
        })
        
        
        .navigationBarTitle(user.name)
            
        .navigationBarItems(trailing: Button(action: {
            self.deleteUser()
        }) {
            Image(systemName: "trash.fill")
        })
        */
    }
    
}

struct TrainerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        TrainerDetailsView()
   //     TrainerDetailsView(user: User(name: "Birds of Prey", poster: "birds"))
        
    }
}


