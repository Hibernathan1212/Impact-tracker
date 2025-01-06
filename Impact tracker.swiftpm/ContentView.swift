import SwiftUI

struct ContentView: View {
    @State var entries: [Entry] = DataManager.shared.load()
    @State var showDeleteConfirmation = false
    @State var showAddEntry = false
    @State var showSettings = false
    
//    @StateObject var dataViewModel: DataViewModel = .init()
        
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section {
                        NavigationLink {
                            DetailProgressView(entries: $entries)
                                .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            SimpleProgressView(entries: $entries)
                        }
                        .padding(.vertical, 8)
                    }
                    .frame(height: 360)
                    
                    Section {
                        NavigationLink {
                            LogsView(entries: $entries)
                                .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            SimpleLogsView(entries: $entries)
                        }
//                        .aspectRatio(1, contentMode: .fill)
//                        .padding()
                        .frame(height: 150)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Impact tracker")
                            .font(.headline)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Button(action: { toggleAppearance() }) {
                                Label("Appearance", systemImage: "moon.stars")
                            }
                            Button(action: { showDeleteConfirmation = true }) {
                                Label {
                                    Text("Delete All Data").tint(.red)
                                } icon: {
                                    Image(systemName: "trash")
                                        .foregroundStyle(.black)
                                }
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Button(action: { showAddEntry = true }) {
                            Image(systemName: "plus")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.blue)
                                .clipShape(Circle())
//                                .shadow(radius: 10)
                        }
//                        .shadow(radius: 10)
                        .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $showAddEntry) {
            AddEntryView(entries: $entries)
        }
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("Confirm Deletion"),
                message: Text("Are you sure you want to delete all logs?"),
                primaryButton: .destructive(Text("Delete")) {
                    deleteAllData()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private func toggleAppearance() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let window = windowScene.windows.first else {
                    return
                }
        
    //        if let window = UIApplication.shared.windows.first {
            if window.overrideUserInterfaceStyle == .light {
                window.overrideUserInterfaceStyle = .dark
            } else if window.overrideUserInterfaceStyle == .dark {
                window.overrideUserInterfaceStyle = .unspecified
            } else {
                window.overrideUserInterfaceStyle = .light
            }
    //        }
    }

    private func deleteAllData() {
        entries.removeAll()
        UserDefaults.standard.removeObject(forKey: "entries")
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
