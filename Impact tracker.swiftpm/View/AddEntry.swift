//
//  File.swift
//  Impact tracker
//
//  Created by Nathan Thurber on 2/1/25.
//

import Foundation
import SwiftUI

struct AddEntryView: View {
    @Binding var entries: [Entry]
    @Environment(\.dismiss) var dismiss
    @State private var showCategoryMenu = false
    @State private var components = [Component : Double]()  // Changed to @State
    
//    @State private var title: String = ""
//    @State private var content: String = ""
    @State private var editingText: [Component: String] = [:]
    
    @FocusState private var focusedField: Component?
    
    var currentDateTitle: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: Date())
    }
    
    var body: some View {
        NavigationStack {  // Changed from NavigationView
            VStack {
                List {
                    ForEach(Array(components.keys), id: \.self) { key in
//                        Section {
                            VStack(alignment: .leading) {
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
//                                    .overlay(RoundedRectangle()/*.stroke(Color.black, lineWidth: 1)*/)
//                                    .textFieldStyle(.roundedBorder)
                                    
                                    Text(key.unit)
                                        .font(.headline)
//                                }
                            }
                            .padding(.bottom, 8)
                            .padding(.top, 8)

                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteEntry(component: key)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                
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
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Adjust layout
                }
                ToolbarItem(placement: .principal) {
                    Text(currentDateTitle)
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newEntry = Entry(/*title: title,*/
                                          date: Date(),
                                          components: components)
                        entries.append(newEntry)
                        DataManager.shared.save(entries: entries)
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing) // Adjust layout
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    func deleteEntry(component: Component) {
        components[component] = nil
//        if let index = component.firstIndex(where: { $0.id == component.id }) {
//            component.remove(at: index)
//        }
    }
}

// Modified CategoryMenu to use Component enum
struct CategoryMenu: View {
    @Binding var selectedSubEntries: [EntryComponent]
    
    var body: some View {
        VStack {
            Text("Select a Category")
                .font(.headline)
                .padding()
            
            List {
                ForEach(Component.allCases) { componentType in
                    Button(componentType.displayName) {
                        selectedSubEntries.append(
                            EntryComponent(type: componentType, value: 0)
                        )
                    }
                }
            }
        }
        .frame(width: 300, height: 400)
    }
}
