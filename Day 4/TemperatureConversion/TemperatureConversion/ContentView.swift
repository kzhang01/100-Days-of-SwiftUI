//
//  ContentView.swift
//  TemperatureConversion
//
//  Created by Karina Zhang on 12/21/20.
//

import SwiftUI

struct ContentView: View {
    @State private var input = ""
    @State private var inputType = 1
    @State private var outputType = 1
    
    let tempTypes = ["Celsius", "Fahrenheit", "Kelvin"]
    
    func celsiusToFahrenheit(input: Double) -> Double {
        return (input * (9/5)) + 32
    }
    func fahrenheitToCelsius(input: Double) -> Double {
        return ((input - 32) * (5/9))
    }
    
    var convertedValue: Double {
        let inputDouble = Double(input) ?? 0
        
        //if no conversion needed, return input
        if inputType == outputType {
            return inputDouble
        }
        
        //Celsius to Fahrenheit
        if inputType == 0 && outputType == 1 { return celsiusToFahrenheit(input: inputDouble) }
        //Celsius to Kelvin
        if inputType == 0  && outputType == 2 { return inputDouble + 273.15 }
        
        //Fahrenheit to Celsius
        if inputType == 1 && outputType == 0 { return fahrenheitToCelsius(input: inputDouble) }
        //Fahrenheit to Kelvin
        if inputType == 1 && outputType == 2 { return fahrenheitToCelsius(input: inputDouble) + 273.15 }
        
        //Kelvin to Celsius
        if inputType == 2 && outputType == 0 { return inputDouble - 273.15 }
        //Kelvin to Fahrenheit
        if inputType == 2 && outputType == 1 { return celsiusToFahrenheit(input: inputDouble - 273.15) }
        
        return 0
    }
   
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature", text: $input)
                        .keyboardType(.decimalPad)
                }
                
                Section (header: Text("Input")) {
                    Picker("Unit", selection: $inputType) {
                        ForEach(0 ..< tempTypes.count) {
                            Text("\(self.tempTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section (header: Text("Output")) {
                    
                    Picker("Unit", selection: $outputType) {
                        ForEach(0 ..< tempTypes.count) {
                            Text("\(self.tempTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                    
                Section (header: Text("Converted value")) {
                    Text("\(convertedValue, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Temperature Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
