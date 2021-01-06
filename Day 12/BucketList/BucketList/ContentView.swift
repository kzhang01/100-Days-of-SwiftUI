//
//  ContentView.swift
//  BucketList
//
//  Created by Karina Zhang on 1/5/21.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = false
    
    @State private var showingAuthenticationAlert = false
    @State private var authenticationError = ""

    var body: some View {
        ZStack {
            if isUnlocked {
                UnlockedView()
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: $showingAuthenticationAlert) {
            Alert(title: Text("Error"), message: Text(self.authenticationError), dismissButton: .default(Text("OK")))
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.authenticationError = "\(authenticationError?.localizedDescription ?? "Unknown error.")"
                        self.showingAuthenticationAlert = true
                    }
                }
            }
        } else {
            self.authenticationError = "Biometric authentication unavailable."
            self.showingAuthenticationAlert = true
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
