//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Karina Zhang on 1/1/21.
//

import SwiftUI

enum AlertType {
    case confirmation
    case error
}

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var errorMessage = ""
    @State private var showingAlert = false
    @State var alertType = AlertType.confirmation
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibility(hidden: true)
                    Text("Your total is $\(self.order.orderStruct.cost, specifier: "%.2f")")
                        .font(.title)
                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        
        .alert(isPresented: $showingAlert) { () -> Alert in
            switch alertType {
                case .confirmation:
                    return Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
                case .error:
                    return Alert(title: Text("Something went wrong"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.orderStruct) else {
            self.errorMessage = "Failed to encode order"
            self.alertType = .error
            self.showingAlert = true
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                self.errorMessage = "No data in response: \(error?.localizedDescription ?? "Unknown error.")"
                self.alertType = .error
                self.showingAlert = true
                return
            }

            if let decodedOrder = try? JSONDecoder().decode(OrderStruct.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderStruct.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.alertType = .confirmation
                self.showingAlert = true
            } else {
                self.errorMessage = "Invalid response from server"
                self.alertType = .error
                self.showingAlert = true
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
