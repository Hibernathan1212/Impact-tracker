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
                Text("Progress").font(.title3)
                Chart(entries) { entry in
                    Plot {
                        LineMark(x: .value("Day", entry.date),
                                 y: .value("Carbon Footprint", entry.carbonFootprint))
                    }
                    .interpolationMethod(.catmullRom)
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
        }
    }
}

