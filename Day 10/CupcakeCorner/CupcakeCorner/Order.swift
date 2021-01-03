//
//  Order.swift
//  CupcakeCorner
//
//  Created by Karina Zhang on 1/1/21.
//

import SwiftUI

class Order: ObservableObject {
    @Published var orderStruct = OrderStruct()
    
}

struct OrderStruct: Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var extraFrosting = false
    var addSprinkles = false

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    var hasValidAddress: Bool {
        let name = self.name.trimmingCharacters(in: .whitespaces)
        let streetAddress = self.streetAddress.trimmingCharacters(in: .whitespaces)
        let city = self.city.trimmingCharacters(in: .whitespaces)
        let zip = self.zip.trimmingCharacters(in: .whitespaces)
        
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }

    var cost: Double {
        var cost = Double(quantity) * 2
        cost += (Double(type) / 2)
        
        if extraFrosting {
            cost += Double(quantity)
        }

        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }

    init() { }
    
}
