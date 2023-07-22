//
//  ContentView.swift
//  WeSplit
//
//  Created by Lindsey Kartvedt on 7/17/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var isCheckAmountFocus: Bool
    
    let tipPercentages = [15, 18, 20, 22, 0]
    
    var tipAmount: Double {
        return Double(tipPercentage) / 100 * checkAmount
    }
    
    var totalPerPerson: Double {
        return (checkAmount + tipAmount)/Double(numPeople + 2)
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .keyboardType(.decimalPad)
                    .focused($isCheckAmountFocus)
                    
                    Picker("Number of People", selection: $numPeople){
                        ForEach(2..<50){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Amount", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select tip amount")
                }
                
                Section {
                    Text(tipAmount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Tip")
                }
                
                Section {
                    Text(checkAmount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total")
                }
                
                Section {
                    Text(totalPerPerson, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total Per Person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done") {
                        isCheckAmountFocus = false
                    }
                }
            }
        }
    }
    
}

// UIApplication extension
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
