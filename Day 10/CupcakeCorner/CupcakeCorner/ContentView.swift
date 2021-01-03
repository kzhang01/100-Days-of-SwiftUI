//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Karina Zhang on 1/1/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderStruct.type) {
                        ForEach(0..<OrderStruct.types.count, id: \.self) {
                            Text(OrderStruct.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.orderStruct.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.orderStruct.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.orderStruct.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.orderStruct.specialRequestEnabled {
                        Toggle(isOn: $order.orderStruct.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        Toggle(isOn: $order.orderStruct.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
