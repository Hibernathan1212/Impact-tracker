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
    
    var description: String {
        switch self {
            // Transport
            case .car:
                return "Cars contribute to particulate matter (PM) emissions through exhaust gases, tire and brake wear, and fuel combustion. These emissions impact air quality, increasing risks of respiratory and cardiovascular diseases for humans. Environmentally, car emissions exacerbate smog formation and contribute to urban heat islands. Opting for electric or hybrid vehicles, carpooling, or public transport can mitigate these impacts."

            case .plane:
                return "Airplanes emit PM through jet engines, both during combustion and from condensation trails. This impacts air quality near airports and contributes to global warming due to the release of pollutants at high altitudes. Human health effects are less localized but include respiratory issues from ground-level air pollution. Alternatives like trains or offsetting carbon emissions should be considered."

            case .publicTransport:
                return "Public transportation emits significantly less PM per passenger compared to individual cars, making it a cleaner option. However, emissions from buses and trains still contribute to localized air pollution, especially in congested urban areas. By improving efficiency and transitioning to electric or low-emission vehicles, public transport can further reduce environmental and health impacts."

            case .bike:
                return "Bicycles produce negligible PM emissions, making them one of the most environmentally friendly transport options. They have no direct negative effects on air quality or human health. The only environmental impact comes from the production and disposal of materials, such as rubber and metal, used in manufacturing bikes."

            case .walk:
                return "Walking has no environmental impact in terms of particulate matter emissions and is entirely clean and sustainable. It also promotes human health by reducing reliance on motorized transport and improving physical well-being."

            // Food
            case .fruit:
                return "Fruit farming produces minimal PM emissions, mainly from machinery use and fertilizer application. While its impact on human health is minimal, transportation of fruits across long distances can add to the carbon and air pollution footprint. Choosing local and seasonal produce can significantly reduce these impacts."

            case .vegetables:
                return "Vegetable farming has a low PM footprint, primarily from farming equipment and soil disturbance. Human health is positively impacted by a diet rich in vegetables, but emissions can increase with non-local or greenhouse-grown produce. Sustainable farming practices further minimize environmental harm."

            case .poultry:
                return "Poultry farming generates PM from feed production, dust in farming facilities, and equipment emissions. While it has a lower PM footprint than beef, it still contributes to local air quality degradation and can cause respiratory issues for farmworkers. Opting for sustainably farmed poultry can reduce these impacts."

            case .beef:
                return "Beef production is a significant PM contributor due to feedlot dust, methane emissions, and agricultural machinery. It has severe impacts on air quality, contributes to climate change, and poses respiratory risks for those living near large feedlots. Reducing beef consumption or choosing grass-fed, local beef can mitigate these effects."

            case .fish:
                return "Fish farming and commercial fishing emit PM from fuel used in boats and aquaculture machinery. While its PM footprint is generally lower than meat production, overfishing and habitat disruption exacerbate its environmental impact. Choosing sustainably sourced fish helps balance the benefits of seafood with ecological concerns."

            case .dairy:
                return "Dairy production generates PM through feed production, methane emissions, and farming operations. This impacts air quality and contributes to health issues such as asthma in nearby communities. Reducing consumption or choosing local, sustainable dairy products can lessen these effects."

            case .grain:
                return "Grain farming emits PM from machinery during planting and harvesting, as well as from soil disturbance. While it has a lower environmental impact compared to animal-based foods, large-scale monoculture farming can lead to soil degradation and biodiversity loss. Supporting diversified and local farming practices can improve sustainability."

            // Shopping
            case .plastics:
                return "Plastic production releases significant PM from petrochemical facilities, contributing to air pollution and associated health issues such as respiratory and cardiovascular diseases. Improper disposal leads to long-term environmental harm, including marine pollution. Choosing reusable or biodegradable alternatives can drastically reduce its footprint."

            case .paper:
                return "Paper production emits PM during pulp processing and energy-intensive manufacturing. It contributes to deforestation, which exacerbates air quality and climate issues. Recycling paper and opting for digital alternatives can significantly reduce its environmental and health impacts."

            case .clothes:
                return "Clothing production releases PM through textile manufacturing and dyeing processes, particularly for synthetic materials derived from fossil fuels. It also contributes to water and air pollution in production regions. Choosing natural fibers and sustainable brands can reduce the overall impact."

            case .electronics:
                return "Electronics manufacturing produces high PM emissions from mining, energy use, and waste disposal. This contributes to air pollution, health risks, and electronic waste problems. Opting for durable products and recycling old devices can mitigate these effects."

            // Utilities
            case .screenTime:
                return "Digital activities indirectly produce PM from electricity generation, especially in regions relying on coal or natural gas. While the individual impact is small, cumulative usage adds up. Energy-efficient devices and renewable-powered grids can help reduce this footprint."

            case .fridge:
                return "Refrigerators contribute to PM through energy consumption over their lifespan and refrigerant emissions. Older models are less efficient and produce higher emissions. Upgrading to energy-efficient models and proper disposal can mitigate these impacts."

            case .ac:
                return "Air conditioners emit PM indirectly through electricity usage and refrigerant leaks. These emissions contribute to air pollution and climate change. Using energy-efficient systems and optimizing cooling settings can reduce their environmental impact."

            case .heater:
                return "Heaters emit PM either through direct combustion of fuels or indirectly via electricity generation. This impacts both air quality and human health. Choosing renewable energy-powered heating and proper insulation can reduce reliance on heaters."
            }
    }
    
    var unit: String {
        switch self {
            case .car:              " km"
            case .plane:            " km"
            case .publicTransport:  " km"
            case .bike:             " km"
            case .walk:             " km"
            case .fruit:            " kg"
            case .vegetables:       " kg"
            case .poultry:          " kg"
            case .beef:             " kg"
            case .fish:             " kg"
            case .dairy:            " kg"
            case .grain:            " kg"
            case .plastics:         " items"
            case .paper:            " items"
            case .clothes:          " items"
            case .electronics:      " items"
            case .screenTime:       " hours"
            case .fridge:           " hours"
            case .ac:               " hours"
            case .heater:           " hours"
        }
    }
    
    var carbonFootprint: Double {
        switch self {
            // Transport
            case .car: return 1.5 // kg CO₂e per km (average fuel car)
            case .plane: return 0.25 // kg CO₂e per km per passenger (average flight)
            case .publicTransport: return 0.1 // kg CO₂e per km per passenger (bus/train)
            case .bike: return 0.0 // kg CO₂e per km (manufacturing and maintenance)
            case .walk: return 0.0 // Minimal to no CO₂ emissions
            
            // Food (per kg)
            case .fruit: return 0.5 // kg CO₂e per kg (transport-intensive)
            case .vegetables: return 0.3 // kg CO₂e per kg (low-emission farming)
            case .poultry: return 6.0 // kg CO₂e per kg
            case .beef: return 27.0 // kg CO₂e per kg (high methane emissions)
            case .fish: return 5.0 // kg CO₂e per kg (wild or farmed fish varies)
            case .dairy: return 3.0 // kg CO₂e per kg (milk/cheese production)
            case .grain: return 1.5 // kg CO₂e per kg (rice higher due to methane)
            
            // Shopping (per item or average)
            case .plastics: return 6.0 // kg CO₂e per kg of plastic
            case .paper: return 1.5 // kg CO₂e per kg of paper
            case .clothes: return 10.0 // kg CO₂e per item (varies with material)
            case .electronics: return 100.0 // kg CO₂e per device (manufacturing)

            // Utilities (per hour or day)
            case .screenTime: return 0.01 // kg CO₂e per hour (streaming varies)
            case .fridge: return 1.5 // kg CO₂e per day (average fridge)
            case .ac: return 2.0 // kg CO₂e per hour (average air conditioner)
            case .heater: return 2.5 // kg CO₂e per hour (depending on fuel source)
        }
    }
    
    var waterFootprint: Double {
        switch self {
            // Transport
            case .car: return 0.01 // m³ per km (manufacturing and fuel processing)
            case .plane: return 0.002 // m³ per km per passenger
            case .publicTransport: return 0.001 // m³ per km per passenger
            case .bike: return 0.0005 // m³ per km (materials)
            case .walk: return 0.0 // Minimal water usage
            
            // Food (per kg)
            case .fruit: return 100.0 // liters per kg
            case .vegetables: return 50.0 // liters per kg
            case .poultry: return 4000.0 // liters per kg
            case .beef: return 15400.0 // liters per kg
            case .fish: return 3000.0 // liters per kg
            case .dairy: return 1000.0 // liters per liter of milk
            case .grain: return 1500.0 // liters per kg (varies by type)
            
            // Shopping
            case .plastics: return 10.0 // liters per kg
            case .paper: return 5.0 // liters per kg
            case .clothes: return 2700.0 // liters per item (cotton-based)
            case .electronics: return 19000.0 // liters per device (average)

            // Utilities
            case .screenTime: return 0.001 // liters per hour (cooling servers)
            case .fridge: return 5.0 // liters per day (cooling and manufacturing)
            case .ac: return 10.0 // liters per hour (cooling system water usage)
            case .heater: return 0.5 // liters per hour (if using water heating)
        }
    }
    
    var airFootprint: Double { //particulate matter
        switch self {
            // Transport (PM emissions in grams per km or equivalent usage)
            case .car: return 0.02 // PM from exhaust and tire/brake wear
            case .plane: return 0.03 // PM from jet engines per km per passenger
            case .publicTransport: return 0.01 // PM from buses and trains
            case .bike: return 0.0 // Negligible PM emissions
            case .walk: return 0.0 // No PM emissions

            // Food (PM from production processes per kg)
            case .fruit: return 0.005 // PM from fertilizers and transport
            case .vegetables: return 0.004 // PM from farming machinery
            case .poultry: return 0.02 // PM from feed production and farming
            case .beef: return 0.05 // PM from feedlot dust and feed production
            case .fish: return 0.01 // PM from aquaculture and fishing operations
            case .dairy: return 0.03 // PM from feed and methane-related processes
            case .grain: return 0.008 // PM from harvesting and transport

            // Shopping (PM per kg or item from production)
            case .plastics: return 0.05 // PM from manufacturing processes
            case .paper: return 0.01 // PM from pulp and paper production
            case .clothes: return 0.02 // PM from textile production
            case .electronics: return 0.1 // PM from mining and manufacturing

            // Utilities (PM per hour/day of usage)
            case .screenTime: return 0.001 // PM from electricity generation
            case .fridge: return 0.005 // PM from electricity and lifecycle
            case .ac: return 0.01 // PM from electricity and refrigerant leakage
            case .heater: return 0.02 // PM from combustion or electricity
        }
    }
    
    var wasteFootprint: Double {
        switch self {
            // Transport
            case .car: return 0.0001 // kg waste per 1000 km (tires, oil, etc.)
            case .plane: return 0.05 // kg waste per passenger per flight
            case .publicTransport: return 0.01 // kg waste per km
            case .bike: return 0.005 // kg waste per km (tires, chains)
            case .walk: return 0.0 // Minimal
            
            // Food (per kg)
            case .fruit: return 0.05 // kg waste (peels, seeds)
            case .vegetables: return 0.05 // kg waste (stems, skins)
            case .poultry: return 0.1 // kg waste (bones)
            case .beef: return 0.15 // kg waste (bones, fat)
            case .fish: return 0.2 // kg waste (bones, skin)
            case .dairy: return 0.0 // Minimal packaging waste
            case .grain: return 0.01 // kg waste (packaging)
            
            // Shopping
            case .plastics: return 1.0 // kg per kg of product
            case .paper: return 0.1 // kg per kg of product
            case .clothes: return 0.5 // kg waste per item (disposal)
            case .electronics: return 2.5 // kg e-waste per device

            // Utilities
            case .screenTime: return 0.0 // Minimal
            case .fridge: return 20.0 // kg per device (at end-of-life)
            case .ac: return 50.0 // kg per device (at end-of-life)
            case .heater: return 30.0 // kg per device (at end-of-life)
        }
    }
    
    var plasticFootprint: Double {
        switch self {
            // Transport
            case .car: return 0.1 // kg per 1000 km (tires, interior parts)
            case .plane: return 0.05 // kg per passenger per flight
            case .publicTransport: return 0.01 // kg per km
            case .bike: return 0.005 // kg per km (plastic components)
            case .walk: return 0.0 // Minimal
            
            // Food (per kg)
            case .fruit: return 0.2 // kg per kg (packaging)
            case .vegetables: return 0.2 // kg per kg (packaging)
            case .poultry: return 0.3 // kg per kg (packaging)
            case .beef: return 0.3 // kg per kg (packaging)
            case .fish: return 0.4 // kg per kg (packaging)
            case .dairy: return 0.1 // kg per kg (plastic bottles)
            case .grain: return 0.2 // kg per kg (plastic bags)
            
            // Shopping
            case .plastics: return 1.0 // kg per kg
            case .paper: return 0.1 // kg per kg
            case .clothes: return 0.5 // kg (polyester/synthetic fibers)
            case .electronics: return 0.2 // kg per device

            // Utilities
            case .screenTime: return 0.0 // Minimal
            case .fridge: return 10.0 // kg per device (plastic parts)
            case .ac: return 20.0 // kg per device (plastic parts)
            case .heater: return 15.0 // kg per device (plastic parts)
        }
    }
    
}

//enum Components: String, Codable {
//    case:
//    
//}
