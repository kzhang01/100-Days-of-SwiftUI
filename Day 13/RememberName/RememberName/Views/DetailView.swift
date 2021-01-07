//
//  DetailView.swift
//  RememberName
//
//  Created by Karina Zhang on 1/6/21.
//

import SwiftUI
import CoreLocation

struct DetailView: View {
    @State private var image: Image?
    @State private var showing = 0
    
    let contact: Contact
    
    var contactLocation: CLLocationCoordinate2D {
        .init(latitude: contact.latitude, longitude: contact.longitude)
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
    
    var body: some View {
        VStack {
            Picker(selection: $showing, label: Text("")) {
                Text("Photo").tag(0)
                Text("Event Location").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
 
            switch showing {
                case 0:
                    image?
                        .resizable()
                        .scaledToFit()
                    
                case 1:
                    Text("You and \(contact.wrappedName) met here.")
                        .font(.caption)
                    
                    MapView(location: contactLocation)
                        .frame(height: 300)
               
                default:
                    Text("Something went wrong.")
            }

            Spacer()
        }
        .navigationBarTitle(contact.wrappedName)
        .onAppear(perform: loadImage)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let contact: Contact = {
        let contact = Contact()
        contact.id = UUID()
        contact.name = "Test contact"
        return contact
    }()
    
    static var previews: some View {
        RowView(contact: contact)
    }
}
