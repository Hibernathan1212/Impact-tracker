//
//  File.swift
//  Impact tracker
//
//  Created by Nathan Thurber on 3/1/25.
//

import Foundation
import SwiftUI
//import Charts

struct SimpleLogsView: View {
    @Binding var entries: [Entry]
        
    var body: some View {
        VStack {
            Grid(alignment: .leading/*, horizontalSpacing: 16*/, verticalSpacing: 8) {
                let entry: Entry? = entries.last

//                GridRow {
                    if entry != nil {
                        Text("\(entry!.date.formatted(date: .long, time: .omitted))").bold().font(.headline).italic()
                    } else {
                        Text("Add your first log!").bold().font(.headline).italic()
                    }
//                }
                GridRow {
                    Text("CO₂: ") +
                    Text(String(format: "%.1f", entry?.carbonFootprint ?? "")).italic() + Text("kg ")
                    
                    Text("Water: ") +
                    Text(String(format: "%.1f", entry?.waterFootprint ?? "")).italic() + Text("m³ ")
                }
                GridRow {
                    Text("Air PM: ") +
                    Text(String(format: "%.1f", entry?.airFootprint ?? "")).italic() + Text("g ")
                    
                    Text("Waste: ") +
                    Text(String(format: "%.1f", entry?.wasteFootprint ?? "")).italic() + Text("kg ")
                }
                GridRow {
                    Text("Plastic: ") +
                    Text(String(format: "%.1f", entry?.airFootprint ?? "")).italic() + Text("kg ")
                    
                    Text("Distance: ") +
                    Text(String(format: "%.1f", entry?.distance ?? "")).italic() + Text("km ")
                }
            }
        }
    }
}
