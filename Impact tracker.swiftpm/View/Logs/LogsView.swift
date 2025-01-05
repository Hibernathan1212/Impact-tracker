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
//    @State private var showAddEntry = false
//    @State private var showSettings = false

    var body: some View {
        NavigationView {
            ZStack {
                List(entries) { entry in
                    Section {
                        NavigationLink(destination: JournalDetailView(entry: entry)) {
                            Grid(alignment: .leading, verticalSpacing: 10) {
                                //                        GridRow {
                                //                            if entry != nil {
                                //                                Text("\(entry.date.formatted(date: .long, time: .omitted))").bold().font(.headline).italic()
                                //                            } else {
                                //                                Text("Add your first log!").bold().font(.headline).italic()
                                //                            }
                                Text("\(entry.date.formatted(date: .long, time: .omitted))").bold().font(.headline).italic()
                                //                        }
                                GridRow {
                                    Text("CO₂: ") +
                                    Text(String(format: "%.1f", entry.carbonFootprint)).italic() + Text("kg")
                                    
                                    Text("Water: ") +
                                    Text(String(format: "%.1f", entry.waterFootprint)).italic() + Text("m³")
                                }
                                GridRow {
                                    Text("Air PM: ") +
                                    Text(String(format: "%.1f", entry.airFootprint)).italic() + Text("g")
                                    
                                    Text("Waste: ") +
                                    Text(String(format: "%.1f", entry.wasteFootprint)).italic() + Text("kg")
                                }
                                GridRow {
                                    Text("Plastic: ") +
                                    Text(String(format: "%.1f", entry.airFootprint)).italic() + Text("kg")
                                    
                                    Text("Distance: ") +
                                    Text(String(format: "%.1f", entry.distance)).italic() + Text("km")
                                }
                            }
                        }

                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteEntry(entry: entry)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
//                .onDelete(perform: deleteEntries)
                .navigationTitle("Logs")
//                .toolbar {
////                    ToolbarItem(placement: .topBarLeading) {
////                        Text("Logs")
////                            .font(.headline)
////                    }
//                }
            }
            
        }
    }
    func deleteEntry(entry: Entry) {
//        for en in entries {
//            if en.id == entry.id {
//                entries.remove(at: entries.firstIndex(of: en)!)
//            }
//        }
//        UserDefaults.standard.removeObject(forKey: String(entry.id))
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries.remove(at: index)
        }
        
    }
        
//    func deleteEntries(offsets: IndexSet) {
//        entries.remove(atOffsets: offsets)
//    }
}

