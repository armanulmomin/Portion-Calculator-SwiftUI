//
//  ContentView.swift
//  Portion Calculator
//
//  Created by Arman on 20/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var tipPct = 0
    @State private var numPeople = 1
    @State private var total = "0"
    @State private var calculate = false
    
    
    var canAddDecimal: Bool {
        total.filter({$0 == "."}).count == 0 ? true : false
    }
    
    func addDigit(_ number: String) {
        if number == "." {
            // Only add decimal if allowed
            if canAddDecimal {
                total += number
            }
        } else {
            // For normal digits, check canAddDigit
            if canAddDigit {
                total = total == "0" ? number : total + number
            }
        }
    }

    var canAddDigit: Bool {
        guard let decIndex = total.firstIndex(of: ".") else { return true }
        let index = total.distance(from: total.startIndex, to: decIndex)
        return (total.count - index - 1) < 2
    }
    var body: some View {
        NavigationStack {
            VStack {
                Text(total)
                    .font(.system(size: 70))
                    .frame(width: 260, alignment: .trailing)
                    .padding(.vertical,1)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                HStack {
                    ForEach(7...9,id: \.self){ number in
                        numberButton(number: "\(number)")
                    }
                    
                }
                HStack {
                    ForEach(4...6,id: \.self){ number in
                        numberButton(number: "\(number)")
                    }
                    
                }
                HStack {
                    ForEach(1...3,id: \.self){ number in
                        numberButton(number: "\(number)")
                    }
                    
                }
                HStack{
                    numberButton(number: "0")
                    numberButton(number: ".")
                    Button {
                        if total.count == 1{
                            total = "0"
                        }
                        else
                        {
                            total.removeLast()
                        }
                    } label: {
                        Image(systemName: "delete.backward.fill")
                            .font(.largeTitle)
                            .bold()
                            .frame(width: 80, height: 80)
                            .background(.gray)
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                    }
                    
                }
                HStack {
                    Text("Tip")
                    Picker(selection: $tipPct,label: Text("Tip")){
                        ForEach(0...100, id: \.self){ tip in
                            Text("\(tip)%")
                            
                        }
                    }
                    .buttonStyle(.bordered)
                }
                HStack {
                    Text("Number of People")
                    Picker(selection: $numPeople,label: Text("Number of People")){
                        ForEach(1...20, id: \.self){ num in
                            Text("\(num)")
                            
                        }
                    }
                    .buttonStyle(.bordered)
                }
                HStack{
                    Button("Calculate"){
                        calculate = true
                    }.sheet(isPresented: $calculate) {
                        TotalsView(total: Double(total) ?? 0, tipPct: tipPct, numPeople: numPeople)
                            .presentationDetents([.medium])
                    }
                    Button("Clear"){
                        total = "0"
                    }
                }.disabled(Double(total) == 0)
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            .navigationTitle("Portion Calculator")
        }
        
        
    }
    
    func numberButton(number: String) -> some View {
        Button {
            addDigit(number)
        } label: {
            Text(number)
                .font(.largeTitle)
                .bold()
                .frame(width: 80, height: 80)
                .background(.purple)
                .foregroundStyle(.white)
                .clipShape(Circle())
        }
    }
}

#Preview {
    ContentView()
}
