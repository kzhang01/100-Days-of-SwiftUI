//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Karina Zhang on 1/4/21.
//

import CoreData
import SwiftUI

enum Predicate: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var results: FetchedResults<T> { fetchRequest.wrappedValue }

    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { result in
            self.content(result)
        }
    }

    init(filterKey: String,
         filterValue: String,
         predicate: Predicate,
         sortDescriptors: [NSSortDescriptor],
         @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(),
                                            sortDescriptors: sortDescriptors,
                                            predicate: NSPredicate(format: "%K \(predicate.rawValue)[c] %@", filterKey, filterValue))
        self.content = content
    }
    
}
