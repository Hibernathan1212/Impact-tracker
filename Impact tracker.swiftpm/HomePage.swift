////
////  File.swift
////  Impact tracker
////
////  Created by Nathan Thurber on 2/1/25.
////
//
//import Foundation
//import SwiftUI
//
//struct HomePageView: View {
//    @State private var entries: [Entry] = JournalDataManager.shared.load()
//    @State private var showAddEntry = false
//    @State private var showDeleteConfirmation = false
//
////    @AppStorage("dataRetentionPeriod") private var dataRetentionPeriod: String = "Forever"
//
//    
//    var body: some View {        
//        NavigationView {
//            ZStack {
//                
//                List(entries) { entry in
//                    NavigationLink(destination: JournalDetailView(entry: entry)) {
//                        VStack(alignment: .leading) {
//                            Text(entry.title)
//                                .font(.headline)
//                            Text(entry.date, style: .date)
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                    }
//                }
////                .navigationTitle("Journal")
//                .toolbar {
//                    ToolbarItem(placement: .topBarLeading) {
//                        Text("Impact tracker")
//                            .font(.headline)
//                            .padding()
//                    }
//                    ToolbarItem(placement: .topBarTrailing) {
//                        Menu {
//                            Button(action: { toggleAppearance() }) {
//                                Label("Appearance", systemImage: "moon.stars")
//                            }
//                            Button(action: { showDeleteConfirmation = true }) {
//                                Label {
//                                    Text("Delete All Data").tint(.red)
//                                } icon: {
//                                    Image(systemName: "trash")
//                                        .foregroundStyle(.black)
//                                }
//                            }
//                            .pickerStyle(SegmentedPickerStyle())
//                            .padding()
//                        } label: {
//                            Image(systemName: "ellipsis.circle")
//                        }
//                    }
//                }
//                VStack {
////                    NavigationLink(destination: LogListView()) {
////                        Text("Second View")
////                    }
//                    Button(action: { showDeleteConfirmation = true }) {
////                        Text("test")
//                                                  
//                        Image(systemName: "plus")
//                            .frame(maxWidth: .infinity)
//                            .foregroundColor(.white)
//                            .frame(width: 375, height: 420)
//                            .background(Color.gray.opacity(0.2))
//                            .cornerRadius(10)
//                    }
//                    
//                    .padding(.top, 20)
//                    .padding(.bottom, 10) 
//                    Button(action: {}) {
//                        Image(systemName: "plus")
//                            .frame(maxWidth: .infinity)
//                            .foregroundColor(.white)
//                            .frame(width: 375, height: 180)
//                            .background(Color.gray.opacity(0.2))
//                            .cornerRadius(10)
//                    }
//                    Spacer()
//                }
//                VStack {
//                    Spacer()
//                    HStack {
////                        Spacer()
//                        Button(action: { showAddEntry = true }) {
//                            Image(systemName: "plus")
//                                .font(.largeTitle)
//                                .foregroundColor(.white)
//                                .frame(width: 60, height: 60)
//                                .background(Color.blue)
//                                .clipShape(Circle())
//                                .shadow(radius: 10)
//                        }
//                        .padding()
//                    }
//                }
//            }
//            .sheet(isPresented: $showAddEntry) {
//                AddEntryView(journalEntries: $entries)
//            }
//            .alert(isPresented: $showDeleteConfirmation) {
//                Alert(
//                    title: Text("Confirm Deletion"),
//                    message: Text("Are you sure you want to delete all journal entries?"),
//                    primaryButton: .destructive(Text("Delete")) {
//                        deleteAllData()
//                    },
//                    secondaryButton: .cancel()
//                )
//            }
//        }
//    }
//    private func toggleAppearance() {
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                let window = windowScene.windows.first else {
//                    return
//                }
//        
////        if let window = UIApplication.shared.windows.first {
//            if window.overrideUserInterfaceStyle == .light {
//                window.overrideUserInterfaceStyle = .dark
//            } else if window.overrideUserInterfaceStyle == .dark {
//                window.overrideUserInterfaceStyle = .unspecified
//            } else {
//                window.overrideUserInterfaceStyle = .light
//            }
////        }
//    }
//
//    private func deleteAllData() {
//        entries.removeAll()
//        UserDefaults.standard.removeObject(forKey: "journalEntries")
//    }
//    
////    func pruneOldEntries() {
////        let calendar = Calendar.current
////        let now = Date()
////        var cutoffDate: Date?
////
////        switch UserDefaults.standard.string(forKey: "dataRetentionPeriod") ?? "Forever" {
////        case "1 Week":
////            cutoffDate = calendar.date(byAdding: .weekOfYear, value: -1, to: now)
////        case "1 Month":
////            cutoffDate = calendar.date(byAdding: .month, value: -1, to: now)
////        case "1 Year":
////            cutoffDate = calendar.date(byAdding: .year, value: -1, to: now)
////        default:
////            return
////        }
////
////        if let cutoff = cutoffDate {
////            journalEntries.removeAll { $0.date < cutoff }
////            save()
////        }
////    }
//}
