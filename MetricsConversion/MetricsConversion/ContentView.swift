//
//  ContentView.swift
//  MetricsConversion
//
//  Created by ZML-MAC-RahulM-01 on 22/07/26.
//

/*
 Your challenge
 You need to build an app that handles unit conversions: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.

 Length conversion: users choose meters, kilometers, feet, yards, or miles.
 
 If you were going for length conversion you might have:

 A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
 A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
 A text field where users enter a number.
 A text view showing the result of the conversion.
 So, if you chose meters for source unit and feet for output unit, then entered 10, you’d see 32.81 as the output.

to use a different format option for your text field, because .currency and .percent don’t make sense here. You should choose .number instead, which is suitable for standard numerical input.
 */

import SwiftUI

struct ContentView: View {
    
    @State private var inputValue: Double = 0
    @State private var inputUnit: String = "meters"
    @State private var outputunit: String = "meters"
    @FocusState private var isfocused: Bool
    
    let unitArray = ["meters", "kilometers", "feet", "yard", "miles"]
    
    var inputConverted: Double {
        let value = inputValue
        
        switch (inputUnit) {
        case "meters":
            return value
        case "kilometers":
            return value * 1000
        case "feet":
            return value * 3.28084
        case "yard":
            return value * 1093.61
        case "miles":
            return value * 1609.34
        default:
            return value
        }
    }
    
    var outputConverted: Double {
        let value: Double = inputConverted
        
        switch outputunit {
        case "meters":
            return value
            
        case "kilometers":
            return value / 1000
            
        case "feet":
            return value / 3.28084
            
        case "yard":
            return value / 1093.61
            
        case "miles":
            return value / 1609.34
            
        default:
            return value
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input value which needs to be converted") {
                    TextField("Input Value", value: $inputValue, format: .number)
                        .focused($isfocused)
                    
                    Picker("Input unit",selection: $inputUnit) {
                        ForEach(unitArray,id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Picker("Output unit",selection: $outputunit) {
                        ForEach(unitArray,id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                
                Section("Output converted unit") {
                    Text("\(outputConverted) " + outputunit)
                }
            }
            .navigationTitle("Length Conversion")
            .toolbar {
                
                if isfocused {
                    Button("Done") {
                        isfocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
