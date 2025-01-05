//
//  File.swift
//  Impact tracker
//
//  Created by Nathan Thurber on 2/1/25.
//

import Foundation
import SwiftUI

struct JournalDetailView: View {
    let entry: Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
//            Text(entry.title)
//                .font(.largeTitle)
//                .padding(.bottom, 5)
            Text(entry.date, style: .date)
                .font(.subheadline)
                .foregroundColor(.gray)
            Divider()
            ScrollView {
//                Text(entry.content)
//                    .font(.body)
            }
        }
        .padding()
        .navigationTitle("Entry")
        .navigationBarTitleDisplayMode(.inline)
    }
}
