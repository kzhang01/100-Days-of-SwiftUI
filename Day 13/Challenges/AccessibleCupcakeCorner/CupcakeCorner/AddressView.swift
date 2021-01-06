//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Karina Zhang on 1/1/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderStruct.name)
                TextField("Street Address", text: $order.orderStruct.streetAddress)
                TextField("City", text: $order.orderStruct.city)
                TextField("Zip", text: $order.orderStruct.zip)

            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.orderStruct.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
