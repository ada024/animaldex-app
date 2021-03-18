//
//  AnimalRow.swift
//  AnimalDex App
//
//  Created by Andreas M. (ada024) on 18/03/2021.
//

import SwiftUI

struct AnimalRow: View {
    var animal: Animal
    
    var body: some View {
        HStack {
            AsyncImage(
                url:  URL(string: animal.image!)!,
                           placeholder: { Text("Loading ...") },
                image: { Image(uiImage: $0).resizable() }
            ).frame(maxWidth: 50, maxHeight: 50)
            Text(animal.name)
            Spacer()
        }
        
        
    }
}

struct AnimalRow_Previews: PreviewProvider {
    static var previews: some View {
        AnimalRow(animal: Animal( name: "Meow", description: "Som description", image: "", type: "Normal", trainer: Trainer( name: "Ash", image: "http://2.bp.blogspot.com/-XlaaXhBrxNE/T32pghUghzI/AAAAAAAAABQ/oa7wmN6OUfk/s1600/Swift.jpg")))
    }
}
