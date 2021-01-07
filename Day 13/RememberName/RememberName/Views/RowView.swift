//
//  RowView.swift
//  RememberName
//
//  Created by Karina Zhang on 1/6/21.
//

import SwiftUI

struct RowView: View {
    @State private var image: Image?
    let contact: Contact
    
    var body: some View {
        NavigationLink(destination: DetailView(contact: contact)) {
            HStack {
                image?
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                Text(contact.wrappedName)
                    .font(.headline)
                
            }
        }
        .frame(height: 80)
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        FileManager.default.readImage(from: contact.wrappedID.uuidString) { (image, error) in
            if let error = error {
                print(error)
            } else if let image = image {
                self.image = Image(uiImage: image)
            }
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static let contact: Contact = {
        let contact = Contact()
        contact.id = UUID()
        contact.name = "Test person"
        return contact
    }()
        
    static var previews: some View {
        RowView(contact: contact)
    }
}
