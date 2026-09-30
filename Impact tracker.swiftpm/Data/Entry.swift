//
//  File.swift
//  Impact tracker
//
//  Created by Nathan Thurber on 2/1/25.
//

import Foundation
import SwiftUI

/*
 carbon
 water
 air
 waste
 plastic
 */


struct Entry: Identifiable, Codable, Equatable {
//    var title: String
//    var content: String
    var date: Date
    
    var components: [Component : Double] //type then value
    
    var carbonFootprint: Double {
        var carbonFootprint: Double = 0
        for component in components {
            carbonFootprint += component.value * component.key.carbonFootprint
        }
        return carbonFootprint
    }
    
    var waterFootprint: Double {
        var waterFootprint: Double = 0
        for component in components {
            waterFootprint += component.value * component.key.waterFootprint
        }
        return waterFootprint
    }
    
    var airFootprint: Double {
        var airFootprint: Double = 0
        for component in components {
            airFootprint += component.value * component.key.airFootprint
        }
        return airFootprint
    }
    
    var wasteFootprint: Double {
        var wasteFootprint: Double = 0
        for component in components {
            wasteFootprint += component.value * component.key.wasteFootprint
        }
        return wasteFootprint
    }
    
    var plasticFootprint: Double {
        var plasticFootprint: Double = 0
        for component in components {
            plasticFootprint += component.value * component.key.plasticFootprint
        }
        return plasticFootprint
    }
    
    var distance: Double {
        var distance: Double = 0
        distance += components[Component.car] ?? 0
        distance += components[Component.plane] ?? 0
        distance += components[Component.publicTransport] ?? 0
        distance += components[Component.walk] ?? 0
        distance += components[Component.bike] ?? 0
        return distance
    }
    
    
    var id = UUID()
}

struct EntryComponent: Identifiable, Codable, Equatable {
//    var name: String
    var type: Component
    var value: Double
//    var unit: String
    
    var id = UUID()
}

enum Component: Identifiable, CaseIterable, Codable {
    // Transport
    case car
    case plane
    case publicTransport
    case bike
    case walk
    
    // Food
    case fruit
    case vegetables
    case poultry
    case beef
    case fish
    case dairy
    case grain
    
    // Shopping
    case plastics
    case paper
    case clothes
    case electronics
    
    // Utilities
    case screenTime
    case fridge
    case ac
    case heater
//    
//    var category: Category {
//        switch self {
//        case .car, .plane, .publicTransport, .bike, .walk:
//            return .transport
//        case .fruit, .vegetables, .poultry, .beef, .fish, .dairy, .grain:
//            return .food
//        case .plastics, .paper, .clothes, .electronics:
//            return .shopping
//        case .screenTime, .fridge, .ac, .heater:
//            return .utilities
//        }
//    }
    
    var id: Self { return self }
    
    var displayName: String {
        switch self {
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
    
    var unit: String {
        switch self {
            case .car, .plane, .publicTransport, .bike, .walk:
                return " km"
            case .fruit, .vegetables, .poultry, .beef, .fish, .dairy, .grain:
                return " kg"
            case .plastics, .paper, .clothes, .electronics:
                return " items"
            case .screenTime, .fridge, .ac, .heater:
                return " hours"
        }
    }
    
    var carbonFootprint: Double {
        switch self {
            // Transport (kg CO₂e per km)
            case .car: return 0.15
            case .plane: return 0.25
            case .publicTransport: return 0.1
            case .bike: return 0.0
            case .walk: return 0.0
            
            // Food (kg CO₂e per kg)
            case .fruit: return 0.5
            case .vegetables: return 0.3
            case .poultry: return 6.0
            case .beef: return 27.0
            case .fish: return 5.0
            case .dairy: return 3.0
            case .grain: return 1.5
            
            // Shopping (kg CO₂e per item)
            case .plastics: return 6.0
            case .paper: return 1.5
            case .clothes: return 10.0
            case .electronics: return 50.0

            // Utilities (kg CO₂e per hour)
            case .screenTime: return 0.01
            case .fridge: return 0.063  // 1.5 per day converted to hourly
            case .ac: return 2.0
            case .heater: return 2.5
        }
    }
    
    var waterFootprint: Double {
        switch self {
            // Transport (m³ per km)
            case .car: return 0.01
            case .plane: return 0.005
            case .publicTransport: return 0.002
            case .bike: return 0.0
            case .walk: return 0.0
            
            // Food (m³ per kg)
            case .fruit: return 0.1
            case .vegetables: return 0.05
            case .poultry: return 4.0
            case .beef: return 15.4
            case .fish: return 3.0
            case .dairy: return 1.0
            case .grain: return 1.5
            
            // Shopping (m³ per item)
            case .plastics: return 0.01
            case .paper: return 0.005
            case .clothes: return 2.7
            case .electronics: return 10.0

            // Utilities (m³ per hour)
            case .screenTime: return 0.000001
            case .fridge: return 0.000208  // 0.005 per day converted to hourly
            case .ac: return 0.01
            case .heater: return 0.0005
        }
    }
    
    var airFootprint: Double {
        switch self {
            // Transport (PM grams per km)
            case .car: return 0.02
            case .plane: return 0.03
            case .publicTransport: return 0.01
            case .bike: return 0.0
            case .walk: return 0.0

            // Food (PM grams per kg)
            case .fruit: return 0.005
            case .vegetables: return 0.004
            case .poultry: return 0.02
            case .beef: return 0.05
            case .fish: return 0.01
            case .dairy: return 0.03
            case .grain: return 0.008

            // Shopping (PM grams per item)
            case .plastics: return 0.05
            case .paper: return 0.01
            case .clothes: return 0.02
            case .electronics: return 0.1

            // Utilities (PM grams per hour)
            case .screenTime: return 0.001
            case .fridge: return 0.0002  // 0.005 per day converted to hourly
            case .ac: return 0.01
            case .heater: return 0.02
        }
    }
    
    var wasteFootprint: Double {
        switch self {
            // Transport (kg waste per km)
            case .car: return 0.0001
            case .plane: return 0.0005
            case .publicTransport: return 0.0001
            case .bike: return 0.00005
            case .walk: return 0.0
            
            // Food (kg waste per kg)
            case .fruit: return 0.05
            case .vegetables: return 0.05
            case .poultry: return 0.1
            case .beef: return 0.15
            case .fish: return 0.2
            case .dairy: return 0.01
            case .grain: return 0.01
            
            // Shopping (kg waste per item)
            case .plastics: return 1.0
            case .paper: return 0.1
            case .clothes: return 0.5
            case .electronics: return 2.5

            // Utilities (kg waste per hour of use, accounting for lifecycle)
            case .screenTime: return 0.0001
            case .fridge: return 0.0023  // 20.0 kg lifecycle / (24 * 365)
            case .ac: return 0.0057      // 50.0 kg lifecycle / (24 * 365)
            case .heater: return 0.0034  // 30.0 kg lifecycle / (24 * 365)
        }
    }
    
    var plasticFootprint: Double {
        switch self {
            // Transport (kg plastic per km)
            case .car: return 0.0001
            case .plane: return 0.00005
            case .publicTransport: return 0.00001
            case .bike: return 0.000005
            case .walk: return 0.0
            
            // Food (kg plastic per kg)
            case .fruit: return 0.2
            case .vegetables: return 0.2
            case .poultry: return 0.3
            case .beef: return 0.3
            case .fish: return 0.4
            case .dairy: return 0.1
            case .grain: return 0.2
            
            // Shopping (kg plastic per item)
            case .plastics: return 1.0
            case .paper: return 0.1
            case .clothes: return 0.5
            case .electronics: return 1.0

            // Utilities (kg plastic per hour, accounting for lifecycle)
            case .screenTime: return 0.0001
            case .fridge: return 0.0011  // 10.0 kg lifecycle / (24 * 365)
            case .ac: return 0.0023      // 20.0 kg lifecycle / (24 * 365)
            case .heater: return 0.0017  // 15.0 kg lifecycle / (24 * 365)
        }
    }
}

//enum Components: String, Codable {
//    case:
//    
//}
