//
//  File.swift
//  Impact tracker
//
//  Created by Nathan Thurber on 3/1/25.
//

import Foundation
import SwiftUI
import Charts

struct SimpleProgressView: View {
    @Binding var entries: [Entry]
    
    var body: some View {
        if entries.isEmpty {
            Text("Not enough data to show progress")
                .font(.title)
                .fontWeight(.bold)
        } else {
            VStack {
//                Text("Carbon Footprint").font(.title3).padding()
                Chart(entries) { entry in
                    Plot {
                        BarMark(x: .value("Day", entry.date, unit: .day),
                                 y: .value("Carbon Footprint", entry.carbonFootprint))
                    }
                }
                .chartYAxisLabel("KG")
                .chartXAxis {
                    AxisMarks { _ in
                        AxisGridLine()
                        AxisValueLabel(format:
                                .dateTime.day(), centered: true)
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
        }
    }
}

