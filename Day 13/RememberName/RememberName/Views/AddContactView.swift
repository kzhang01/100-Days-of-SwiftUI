//
//  AddContactView.swift
//  RememberName
//
//  Created by Karina Zhang on 1/6/21.
//

import SwiftUI
import CoreLocation

struct AddContactView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State private var name = ""
    
    let inputImage: UIImage
    let location: CLLocationCoordinate2D?
    let uuid = UUID()
    
    var saveButton: some View {
        Button("Save") {
            FileManager.default.saveImage(self.inputImage, to: self.uuid.uuidString) { error in
                if let error = error {
                    print(error)
                } else {
                    let contact = Contact(context: self.moc)
                    contact.id = self.uuid
                    contact.name = self.name
                    contact.latitude = self.location?.latitude ?? 0
                    contact.longitude = self.location?.longitude ?? 0
                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Info")) {
                        TextField("Name", text: $name)
                    }
                    
                    Image(uiImage: inputImage)
                        .resizable()
                        .scaledToFit()
                }
            }
            .navigationBarTitle(Text("New Contact"), displayMode: .inline)
            .navigationBarItems(trailing: saveButton)
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(inputImage: UIImage(), location: nil)
    }
}
