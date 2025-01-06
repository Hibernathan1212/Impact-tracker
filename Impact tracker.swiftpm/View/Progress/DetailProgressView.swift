//
//  File.swift
//  Impact tracker
//
//  Created by Nathan Thurber on 3/1/25.
//

import Foundation
import SwiftUI
import Charts

struct DetailProgressView: View {
    @Binding var entries: [Entry]
    
    @State var selection: Selection = Selection.carbonFootprint
    
    var body: some View {
        VStack {
            if entries.isEmpty {
                Text("Not enough data to show progress")
                    .font(.title)
//                    .fontWeight(.bold)
            } else {
                if selection.isComponent {
                    Chart(entries) { entry in
//                        if entry.components[selection.componentSelection!] == nil {
//                            continue
//                        }
                        Plot {
                            LineMark(x: .value("Day", entry.date, unit: .day),
                                     y: .value("Value", entry.components[selection.componentSelection!] ?? 0 ))
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
                    .padding()
                    .frame(height: 320)
                } else {
                    Chart(entries) { entry in
                        Plot {
                            LineMark(x: .value("Day", entry.date, unit: .day),
                                     y: .value("Value", selection.getOverviewValue(entry: entry)))
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
                    .padding()
                    .frame(height: 320)
                }
            }
                        
            Menu {
                Menu("Overview") {
                    Button(Selection.carbonFootprint.displayName) { selection = .carbonFootprint}
                    Button(Selection.waterFootprint.displayName) { selection = .waterFootprint}
                    Button(Selection.airFootprint.displayName) { selection = .airFootprint}
                    Button(Selection.wasteFootprint.displayName) { selection = .wasteFootprint}
                    Button(Selection.plasticFootprint.displayName) { selection = .plasticFootprint}
                    Button(Selection.distance.displayName) { selection = .distance}
                }
                
                Menu("Transport") {
                    Button(Selection.car.displayName) { selection = .car}
                    Button(Selection.plane.displayName) { selection = .plane}
                    Button(Selection.publicTransport.displayName) { selection = .publicTransport}
                    Button(Selection.bike.displayName) { selection = .bike}
                    Button(Selection.walk.displayName) { selection = .walk}
                }
                
                Menu("Food") {
                    Button(Selection.fruit.displayName) { selection = .fruit}
                    Button(Selection.vegetables.displayName) { selection = .vegetables}
                    Button(Selection.poultry.displayName) { selection = .poultry}
                    Button(Selection.beef.displayName) { selection = .beef}
                    Button(Selection.fish.displayName) { selection = .fish}
                    Button(Selection.dairy.displayName) { selection = .dairy}
                    Button(Selection.grain.displayName) { selection = .grain}
                }
                Menu("Shopping") {
                    Button(Selection.plastics.displayName) { selection = .plastics}
                    Button(Selection.paper.displayName) { selection = .paper}
                    Button(Selection.clothes.displayName) { selection = .clothes}
                    Button(Selection.electronics.displayName) { selection = .electronics}
                }
                Menu("Utilites") {
                    Button(Selection.screenTime.displayName) { selection = .screenTime}
                    Button(Selection.fridge.displayName) { selection = .fridge}
                    Button(Selection.ac.displayName) { selection = .ac}
                    Button(Selection.heater.displayName) { selection = .heater}
                }
            } label: {
                Text("\(selection.displayName)")
                Image(systemName: "chevron.up.chevron.down")
            }
            .pickerStyle(.automatic)
            
            Text("\(selection.description)")
                .padding()
                .padding()
        }
    }
}

enum Selection: Identifiable, CaseIterable, Codable  {
    //Overview
    case carbonFootprint
    case waterFootprint
    case airFootprint
    case wasteFootprint
    case plasticFootprint
    case distance
    
    //transport
    case car
    case plane
    case publicTransport
    case bike
    case walk
    
    //food
    case fruit
    case vegetables
    case poultry
    case beef
    case fish
    case dairy
    case grain
    
    //Shopping
    case plastics
    case paper
    case clothes
    case electronics
    
    //Utilites
    case screenTime
    case fridge
    case ac
    case heater
    
    var id: Self { return self }
    
    var isComponent: Bool {
        switch self {
            case .carbonFootprint, .waterFootprint, .airFootprint, .wasteFootprint, .plasticFootprint, .distance:
            return false
        default:
            return true
        }
    }
    
    func getOverviewValue(entry: Entry) -> Double {
        switch self {
        case .carbonFootprint:      return entry.carbonFootprint
        case .waterFootprint:       return entry.waterFootprint
        case .airFootprint:         return entry.airFootprint
        case .wasteFootprint:       return entry.wasteFootprint
        case .plasticFootprint:     return entry.plasticFootprint
        case .distance:             return entry.distance
        default:                    return 0
        }
    }
    
    var componentSelection: Component? {
        switch self {
        case .carbonFootprint, .waterFootprint, .airFootprint, .wasteFootprint, .plasticFootprint, .distance:
            return nil
        case .car:              return Component.car
        case .plane:            return Component.plane
        case .publicTransport:  return Component.publicTransport
        case .bike:             return Component.bike
        case .walk:             return Component.walk
        case .fruit:            return Component.fruit
        case .vegetables:       return Component.vegetables
        case .poultry:          return Component.poultry
        case .beef:             return Component.beef
        case .fish:             return Component.fish
        case .dairy:            return Component.dairy
        case .grain:            return Component.grain
        case .plastics:         return Component.plastics
        case .paper:            return Component.paper
        case .clothes:          return Component.clothes
        case .electronics:      return Component.electronics
        case .screenTime:       return Component.screenTime
        case .fridge:           return Component.fridge
        case .ac:               return Component.ac
        case .heater:           return Component.heater
        }
    }
    
    var displayName: String {
        switch self {
            case .carbonFootprint: return "Carbon Footprint"
            case .waterFootprint: return "Water Footprint"
            case .airFootprint: return "Air Footprint"
            case .wasteFootprint: return "Waste Footprint"
            case .plasticFootprint: return "Plastic Footprint"
            case .distance: return "Distance"
            case .car: return "Car"
            case .plane: return "Plane"
            case .publicTransport: return "Public Transport"
            case .bike: return "Bike"
            case .walk: return "Walk"
            case .fruit: return "Fruit"
            case .vegetables: return "Vegetables"
            case .poultry: return "Poultry"
            case .beef: return "Beef"
            case .fish: return "Fish"
            case .dairy: return "Dairy"
            case .grain: return "Grain"
            case .plastics: return "Plastics"
            case .paper: return "Paper"
            case .clothes: return "Clothes"
            case .electronics: return "Electronics"
            case .screenTime: return "Screen Time"
            case .fridge: return "Fridge"
            case .ac: return "AC"
            case .heater: return "Heater"
        }
    }
    
    var description: String {
        switch self {
            // Overview
        case .carbonFootprint:
            return "Carbon footprints quantify the total carbon dioxide (CO2) released into the atmosphere from activities such as transportation, energy use, and resource consumption. High carbon footprints contribute to climate change, leading to extreme weather events, rising sea levels, and ecosystem disruptions, all of which pose significant threats to human health and livelihoods."
            
        case .waterFootprint:
            return "Water footprints measure the amount of freshwater used directly or indirectly by individuals or organizations. Excessive water use can deplete vital resources, harm aquatic ecosystems, and exacerbate water scarcity, which affects human health through reduced access to clean drinking water and agricultural productivity."
            
        case .airFootprint:
            return "Air footprints assess the release of air pollutants, including particulate matter (PM), from activities like fuel combustion and industrial processes. These pollutants degrade air quality, leading to respiratory and cardiovascular illnesses, and contribute to environmental issues such as acid rain and smog formation."
            
        case .wasteFootprint:
            return "Waste footprints evaluate the quantity and type of waste generated, including landfill contributions and recycling rates. Poor waste management pollutes air, water, and soil, harming ecosystems and exposing humans to toxins that can cause chronic health issues."
            
        case .plasticFootprint:
            return "Plastic footprints track the production, use, and disposal of plastic materials. Improper disposal pollutes land and water, threatening wildlife and ecosystems, while microplastics in the environment can harm human health through food and water contamination."
            
        case .distance:
            return "The environmental impact of travel distance arises from emissions generated by transportation methods. Long-distance travel contributes to air pollution, climate change, and ecosystem disturbance, while also affecting human health through degraded air quality and noise pollution."
            
            // Transport
        case .car:
            return "Car emissions, including particulate matter from exhaust, brake wear, and tire degradation, significantly impact air quality, contributing to respiratory and cardiovascular diseases. These emissions also drive climate change and urban air pollution, emphasizing the need for cleaner transportation options."
            
        case .plane:
            return "Air travel emits pollutants at high altitudes, intensifying global warming and degrading air quality near airports. These effects contribute to respiratory problems and climate change. Reducing flight frequency or choosing sustainable alternatives can mitigate these impacts."
            
        case .publicTransport:
            return "Public transport emits less pollution per passenger than private vehicles, making it a more sustainable option. However, emissions from buses and trains still affect urban air quality. Transitioning to cleaner energy sources can further reduce its environmental and health impacts."
            
        case .bike:
            return "Bicycles have a minimal environmental footprint, producing negligible emissions. Their use promotes cleaner air and mitigates the health risks associated with motorized transport, while offering significant personal health benefits through physical activity."
            
        case .walk:
            return "Walking is a completely emission-free mode of transportation, contributing nothing to air pollution. It supports environmental sustainability while enhancing human health through physical activity and reduced reliance on polluting vehicles."
            
            // Food
        case .fruit:
            return "Fruit production has relatively low environmental impacts, though machinery use and fertilizer application can contribute to air and water pollution. Supporting local and seasonal farming reduces transport emissions and promotes healthier ecosystems."
            
        case .vegetables:
            return "Vegetable farming is environmentally friendly, but emissions can arise from farm equipment and fertilizers. Encouraging sustainable farming practices and consuming locally grown vegetables can reduce environmental harm while supporting human health."
            
        case .poultry:
            return "Poultry farming generates air pollutants from feed production and farm operations, impacting air quality and potentially harming respiratory health. Sustainable practices can reduce its environmental footprint and associated health risks."
            
        case .beef:
            return "Beef production is a major environmental concern due to emissions from feedlots and methane from cattle. These contribute to air quality degradation and climate change, with localized health impacts for communities near large operations. Reducing beef consumption can significantly mitigate these effects."
            
        case .fish:
            return "Fishing and aquaculture contribute to pollution through fuel use and habitat disturbance. While generally less polluting than land-based meat production, overfishing and unsustainable practices can disrupt ecosystems and harm biodiversity, indirectly affecting human health."
            
        case .dairy:
            return "Dairy farming impacts air quality through methane emissions and equipment use, contributing to climate change and local respiratory health risks. Supporting sustainable dairy practices and reducing consumption can minimize these impacts."
            
        case .grain:
            return "Grain farming is less polluting than animal farming but still generates emissions from machinery and soil disruption. Large-scale operations can harm biodiversity and soil health, while supporting sustainable practices can enhance environmental resilience."
            
            // Shopping
        case .plastics:
            return "Plastic production and disposal release harmful air pollutants and toxins that impact both environmental and human health. Microplastics in water and food pose additional risks, making it crucial to reduce single-use plastics and support sustainable alternatives."
            
        case .paper:
            return "Paper production contributes to deforestation and emits air pollutants during processing. These impacts exacerbate climate change and degrade air quality. Recycling and reducing paper use can significantly lower its environmental footprint."
            
        case .clothes:
            return "Clothing production emits pollutants from textile manufacturing and synthetic fiber processing, affecting air and water quality. Choosing sustainable and durable clothing options can mitigate environmental and health harms associated with the fashion industry."
            
        case .electronics:
            return "Electronics manufacturing generates emissions from mining and energy use, contributing to air pollution and environmental degradation. Recycling and choosing energy-efficient devices help reduce these impacts."
            
            // Utilities
        case .screenTime:
            return "Screen time has an indirect environmental impact through electricity generation, which produces pollutants depending on the energy source. Reducing energy consumption and supporting renewable energy can mitigate this footprint."
            
        case .fridge:
            return "Refrigerators contribute to air pollution through electricity use and refrigerant leaks, which also drive climate change. Energy-efficient models and responsible disposal are essential for minimizing their environmental impact."
            
        case .ac:
            return "Air conditioners release pollutants indirectly through energy use and refrigerant emissions, contributing to climate change and local air quality issues. Using energy-efficient systems and optimizing settings can reduce these effects."
            
        case .heater:
            return "Heaters emit pollutants through direct fuel combustion or electricity use, affecting air quality and contributing to climate change. Improving home insulation and using renewable energy sources can reduce dependence on heaters and their environmental impact."
        }
    }

}
