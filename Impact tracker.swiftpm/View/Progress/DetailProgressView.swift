//
//  File.swift
//  Impact tracker
//
//  Created by Nathan Thurber on 3/1/25.
//

import Foundation
import SwiftUI
import Charts

struct DetailProgressView: View {
    @Binding var entries: [Entry]
    
    @State var selection: Component = Component.plane
    
    var body: some View {
        VStack {
            if entries.isEmpty {
                Text("Not enough data to show progress")
                    .font(.title)
//                    .fontWeight(.bold)
            } else {
                Chart(entries) { entry in
                    LineMark(x: .value("Day", entry.date, unit: .day),
                             y: .value("Carbon Footprint", entry.components[selection] ?? 0 ))
                    
                }
                .chartXAxis {
                    AxisMarks { _ in
                        AxisGridLine()
                        AxisValueLabel(format:
                                .dateTime.day(.defaultDigits), centered: true)
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) { _ in
                        AxisGridLine()
                        AxisValueLabel()
                    }
                }
                .frame(height: 320)
            }
                        
            Picker(selection: $selection) {
                ForEach(Component.allCases) { componentType in
                    Button(componentType.displayName) {
                        
                    }
                }
            } label: {
                Text("Category")
            }
            .pickerStyle(.automatic)
            
            Text("\(selection.description)")
                .padding()
                .padding()
        }
    }
}
