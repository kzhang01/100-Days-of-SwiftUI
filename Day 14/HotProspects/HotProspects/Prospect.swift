//
//  Prospect.swift
//  HotProspects
//
//  Created by Karina Zhang on 1/7/21.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var date = Date()
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"

    init() {
        self.people = []
        if let data = loadFile() {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            let url = getDocumentDirectory().appendingPathComponent(Self.saveKey)

            do {
                try encoded.write(to: url, options: [.atomicWrite, .completeFileProtection])
            }
            catch let error {
                print("Could not write data: " + error.localizedDescription)
            }
        }
    }

    private func loadFile() -> Data? {
        let url = getDocumentDirectory().appendingPathComponent(Self.saveKey)
        if let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }

    private func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
