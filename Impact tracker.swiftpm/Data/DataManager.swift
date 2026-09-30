//
//  File.swift
//  Impact tracker
//
//  Created by Nathan Thurber on 2/1/25.
//

import Foundation

class DataManager: @unchecked Sendable {
    static let shared = DataManager()
    private let key = "Entries"
    private let queue = DispatchQueue(label: "com.impacttracker.datamanager")

    func save(entries: [Entry]) {
        queue.async {
            if let encoded = try? JSONEncoder().encode(entries) {
                UserDefaults.standard.set(encoded, forKey: self.key)
            }
        }
    }

    func load() -> [Entry] {
        var entries: [Entry] = []
        queue.sync {
            if let savedData = UserDefaults.standard.data(forKey: key),
               let decoded = try? JSONDecoder().decode([Entry].self, from: savedData) {
                entries = decoded
            }
        }
        return entries
    }
}
