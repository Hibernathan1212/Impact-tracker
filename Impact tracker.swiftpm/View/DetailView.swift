//
//  File.swift
//  Impact tracker
//
//  Created by Nathan Thurber on 2/1/25.
//

import Foundation
import SwiftUI

struct DetailView: View {
    let entry: Entry
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Date header
                Text(entry.date, style: .date)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
                
                Divider()
                
                // List all components
                ForEach(Array(entry.components.sorted { $0.key.displayName < $1.key.displayName }), id: \.key) { component, value in
                    HStack {
                        Text(component.displayName)
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(String(format: "%.1f", value))\(component.unit)")
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
                
                // Summary section
                VStack(alignment: .leading, spacing: 12) {
                    Divider()
                        .padding(.vertical, 8)
                    
                    Grid(alignment: .leading, verticalSpacing: 10) {
                        GridRow {
                            Text("CO₂:")
                            Text(String(format: "%.3g", entry.carbonFootprint)) + Text(" kg ")
                            
                            Text("Water:")
                            Text(String(format: "%.3g", entry.waterFootprint)) + Text(" m³ ")
                        }
                        
                        GridRow {
                            Text("Air PM:")
                            Text(String(format: "%.3g", entry.airFootprint)) + Text(" g ")
                            
                            Text("Waste:")
                            Text(String(format: "%.3g", entry.wasteFootprint)) + Text(" kg ")
                        }
                        GridRow {
                            Text("Plastic:")
                            Text(String(format: "%.3g", entry.airFootprint)) + Text(" kg ")
                            
                            Text("Distance:")
                            Text(String(format: "%.3g", entry.distance)) + Text(" km ")
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Entry Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
