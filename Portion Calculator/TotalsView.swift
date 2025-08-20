//
//  TotalsView.swift
//  Portion Calculator
//
//  Created by Arman on 20/8/25.
//

import SwiftUI

struct TotalsView: View {
    let total : Double
    let tipPct: Int
    let numPeople: Int
    
    var tipAmount: Double{
        total * Double(tipPct)/100
    }
    var totalAmount: Double {
        total + tipAmount
    }
    var portion: Double {
        totalAmount / Double(numPeople)
    }
  
    
    var body: some View {
        NavigationStack {
            VStack {
                Grid(horizontalSpacing: 20){
                    GridRow{
                        Text("Original Bill")
                            .gridColumnAlignment(.leading)
                        Text("\(total, format: .currency(code: "USD"))")
                            .gridColumnAlignment(.trailing)
                    }
                    GridRow{
                        Text("Tip")
                        Text("\(tipAmount, format: .currency(code: "USD"))")
                    }
                    GridRow{
                        Text("Total")
                        Text("\(totalAmount, format: .currency(code: "USD"))")
                    }
                    GridRow{
                        Text("Portion")
                        Text("\(portion, format: .currency(code: "USD"))")
                    }
                }
                .font(.title)
                Image("tips2")
                    .resizable()
                    .frame(width: 150,height: 150)
                Spacer()
                
            }
            .navigationTitle("Amount Owing")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TotalsView(total: 135.20, tipPct: 18, numPeople: 3)
}
