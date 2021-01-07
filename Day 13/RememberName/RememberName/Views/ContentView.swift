//
//  ContentView.swift
//  RememberName
//
//  Created by Karina Zhang on 1/6/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Contact.entity(), sortDescriptors: [
        NSSortDescriptor(key: "name", ascending: true)
    ])
    var contacts: FetchedResults<Contact>
    @State private var showingImagePicker = false
    @State private var addingNewContact = false
    @State private var inputImage: UIImage?
    
    let locationFetcher = LocationFetcher()
    
    var addButton: some View {
        Button(action: {
            self.showingImagePicker = true
        }) {
            Image(systemName: "plus")
                .padding(10)
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: addNewContact) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(contacts, content: RowView.init)
                    .onDelete(perform: deleteContact)
            }
            .navigationBarTitle("Contact List")
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .sheet(isPresented: $addingNewContact) {
                AddContactView(inputImage: self.inputImage ?? UIImage(), location: self.locationFetcher.lastKnownLocation)
                    .environment(\.managedObjectContext, self.moc)
            }
            .onAppear(perform: fetchLocation)
        }
    }
    
    func deleteContact(at offsets: IndexSet) {
        for index in offsets {
            moc.delete(contacts[index])
            FileManager.default.deleteImage(at: contacts[index].wrappedID.uuidString)
        }
        try? moc.save()
    }
    
    func addNewContact() {
        guard inputImage != nil else { return }
        
        addingNewContact = true
    }
    
    func fetchLocation() {
        locationFetcher.start()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
