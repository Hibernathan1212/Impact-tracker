//
//  File.swift
//  Impact tracker
//
//  Created by Nathan Thurber on 6/1/25.
//

import Foundation
import SwiftUI

struct EditEntryView: View {
    @Binding var entry: Entry
    @Environment(\.dismiss) var dismiss
    @State private var showCategoryMenu = false
    @State private var components: [Component : Double]  // Changed to @State
    
//    @State private var title: String = ""
//    @State private var content: String = ""
    @State private var editingText: [Component: String] = [:]
    
    @FocusState private var focusedField: Component?
    
    @State private var hasUnsavedChanges: Bool = false
    
var body: some View {
        NavigationStack {
            ZStack {  // Add ZStack to layer the gesture view
                Color.clear  // Invisible view for gesture handling
                    .contentShape(Rectangle())
                    .onTapGesture {
                        focusedField = nil
                    }
                
                VStack {
                    List {
                        ForEach(Array(entry.components.keys), id: \.self) { key in
                            HStack {
                                Text(key.displayName)
                                    .font(.headline)
                                
                                Spacer()
                                
                                TextField("value", text: Binding(
                                    get: { editingText[key] ?? "\(components[key] ?? 0)" },
                                    set: { newValue in
                                        if let doubleValue = Double(newValue.filter { "0123456789.".contains($0) }) {
                                            components[key] = doubleValue
                                        }
                                    }
                                ))
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                                .focused($focusedField, equals: key)
                                .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
                                    if let textField = obj.object as? UITextField {
                                        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                                    }
                                }
                                
                                Text(key.unit)
                                    .font(.headline)
                            }
                            .padding(.vertical, 8)
                            .swipeActions {
                                Button(role: .destructive) {
                                    deleteEntry(component: key)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .scrollDismissesKeyboard(.immediately)  // Add explicit keyboard dismissal behavior
                    
                    Menu {
                        Menu("Transport") {
                            Button(Component.car.displayName) {
                                if components[Component.car] == nil {
                                    components[Component.car] = 0
                                }
                               focusedField = Component.car
                            }
                            Button(Component.plane.displayName) {
                               if components[Component.plane] == nil {
                                   components[Component.plane] = 0
                                }
                               focusedField = Component.plane
                            }
                            Button(Component.publicTransport.displayName) {
                               if components[Component.publicTransport] == nil {
                                   components[Component.publicTransport] = 0
                                }
                               focusedField = Component.publicTransport
                            }
                            Button(Component.bike.displayName) {
                               if components[Component.bike] == nil {
                                   components[Component.bike] = 0
                                }
                                focusedField = Component.bike
                            }
                            Button(Component.walk.displayName) {
                                if components[Component.walk] == nil {
                                    components[Component.walk] = 0
                                }
                                focusedField = Component.walk
                            }
                        }
                        
                        Menu("Food") {
                            Button(Component.fruit.displayName) {
                                if components[Component.fruit] == nil {
                                    components[Component.fruit] = 0
                                }
                                focusedField = Component.fruit
                            }
                            Button(Component.vegetables.displayName) {
                                if components[Component.vegetables] == nil {
                                    components[Component.vegetables] = 0
                                }
                                focusedField = Component.vegetables
                            }
                            Button(Component.poultry.displayName) {
                                if components[Component.poultry] == nil {
                                    components[Component.poultry] = 0
                                }
                                focusedField = Component.poultry
                            }
                            Button(Component.beef.displayName) {
                                if components[Component.beef] == nil {
                                    components[Component.beef] = 0
                                }
                                focusedField = Component.beef
                            }
                            Button(Component.fish.displayName) {
                                if components[Component.fish] == nil {
                                    components[Component.fish] = 0
                                }
                                focusedField = Component.fish
                            }
                            Button(Component.dairy.displayName) {
                                if components[Component.dairy] == nil {
                                    components[Component.dairy] = 0
                                }
                                focusedField = Component.dairy
                            }
                            Button(Component.grain.displayName) {
                                if components[Component.grain] == nil {
                                    components[Component.grain] = 0
                                }
                                focusedField = Component.grain
                            }
                        }
                        Menu("Shopping") {
                            Button(Component.plastics.displayName) {
                                if components[Component.plastics] == nil {
                                    components[Component.plastics] = 0
                                }
                                focusedField = Component.plastics
                            }
                            Button(Component.paper.displayName) {
                                if components[Component.paper] == nil {
                                    components[Component.paper] = 0
                                }
                                focusedField = Component.paper
                            }
                            Button(Component.clothes.displayName) {
                                if components[Component.clothes] == nil {
                                    components[Component.clothes] = 0
                                }
                                focusedField = Component.clothes
                            }
                            Button(Component.electronics.displayName) {
                                if components[Component.electronics] == nil {
                                    components[Component.electronics] = 0
                                }
                                focusedField = Component.electronics
                            }
                        }
                        Menu("Utilites") {
                            Button(Component.screenTime.displayName) {
                                if components[Component.screenTime] == nil {
                                    components[Component.screenTime] = 0
                                }
                                focusedField = Component.screenTime
                            }
                            Button(Component.fridge.displayName) {
                                if components[Component.fridge] == nil {
                                    components[Component.fridge] = 0
                                }
                                focusedField = Component.fridge
                            }
                            Button(Component.ac.displayName) {
                                if components[Component.ac] == nil {
                                    components[Component.ac] = 0
                                }
                                focusedField = Component.ac
                            }
                            Button(Component.heater.displayName) {
                                if components[Component.heater] == nil {
                                    components[Component.heater] = 0
                                }
                                focusedField = Component.heater
                            }
                        }
                    } label: {
                        Image(systemName: "plus")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button("Cancel") {
//                        focusedField = nil  // Dismiss keyboard
//                        dismiss()
//                    }
//                }
//                
//                ToolbarItem(placement: .principal) {
//                    
//                    let formatter = DateFormatter()
//                    formatter.dateStyle = .medium
//                    
//                    Text(formatter.string(from: entry.date))
//                        .font(.headline)
//                }
//                
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Save") {
//                        focusedField = nil  // Dismiss keyboard
//                        let newEntry = Entry(date: Date(), components: components)
////                        entries.append(newEntry)
//                        entry.components = components
////                        DataManager.shared.save(entries: entries)
//                        dismiss()
//                    }
//                }
//            }
        }
        .ignoresSafeArea(.keyboard)  // Handle keyboard better
    }
    
    func deleteEntry(component: Component) {
        components[component] = nil
    }
}

// Modified CategoryMenu to use Component enum
//struct CategoryMenu: View {
//    @Binding var selectedSubEntries: [EntryComponent]
//    
//    var body: some View {
//        VStack {
//            Text("Select a Category")
//                .font(.headline)
//                .padding()
//            
//            List {
//                ForEach(Component.allCases) { componentType in
//                    Button(componentType.displayName) {
//                        selectedSubEntries.append(
//                            EntryComponent(type: componentType, value: 0)
//                        )
//                    }
//                }
//            }
//        }
//        .frame(width: 300, height: 400)
//    }
//}
