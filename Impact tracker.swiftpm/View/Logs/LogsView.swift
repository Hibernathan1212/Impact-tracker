//
//  File.swift
//  Impact tracker
//
//  Created by Nathan Thurber on 2/1/25.
//

import Foundation
import SwiftUI

struct LogsView: View {
    @Binding var entries: [Entry]
    
    @State var showEditEntry = false

//    @State private var showAddEntry = false
//    @State private var showSettings = false

    var body: some View {
        NavigationView {
            ZStack {
                List(entries.reversed()) { entry in
                    Section {
                        NavigationLink(destination: DetailView(entry: entry)) {
                            Grid(alignment: .leading, verticalSpacing: 10) {
                                
                                Text("\(entry.date.formatted(date: .long, time: .omitted))").bold().font(.headline).italic()
                                //                        }
                                GridRow {
                                    Text("CO₂: ") +
                                    Text(String(format: "%.2g", entry.carbonFootprint)).italic() + Text("kg")
                                    
                                    Text("Water: ") +
                                    Text(String(format: "%.2g", entry.waterFootprint)).italic() + Text("m³")
                                }
                                GridRow {
                                    Text("Air PM: ") +
                                    Text(String(format: "%.2g", entry.airFootprint)).italic() + Text("g")
                                    
                                    Text("Waste: ") +
                                    Text(String(format: "%.2g", entry.wasteFootprint)).italic() + Text("kg")
                                }
                                GridRow {
                                    Text("Plastic: ") +
                                    Text(String(format: "%.2g", entry.airFootprint)).italic() + Text("kg")
                                    
                                    Text("Distance: ") +
                                    Text(String(format: "%.2g", entry.distance)).italic() + Text("km")
                                }
                            }
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteEntry(entry: entry)
                            DataManager.shared.save(entries: entries)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                .navigationTitle("Logs")
            }
            
        }
    }
    func deleteEntry(entry: Entry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries.remove(at: index)
        }
        
    }
}

