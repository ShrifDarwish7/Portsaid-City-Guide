//
//  DirectionModel.swift
//  City Guide Demo
//
//  Created by Sherif Darwish on 6/29/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - DirectionModel
struct DirectionModel {
    let geocodedWaypoints: [GeocodedWaypoint]
    let routes: [Route]
    let status: String
}

// MARK: - GeocodedWaypoint
struct GeocodedWaypoint {
    let geocoderStatus, placeID: String
    let types: [String]
    let partialMatch: Bool?
}

// MARK: - Route
struct Route {
    let bounds: Bounds
    let copyrights: String
    let legs: [Leg]
    let overviewPolyline: OverviewPolyline
    let summary: String
    let warnings, waypointOrder: [Any?]
}

// MARK: - Bounds
struct Bounds {
    let northeast, southwest: Northeast
}

// MARK: - Northeast
struct Northeast {
    let lat, lng: Double
}

// MARK: - Leg
struct Leg {
    let distance, duration: Distance
    let endAddress: String
    let endLocation: Northeast
    let startAddress: String
    let startLocation: Northeast
}

// MARK: - Distance
struct Distance {
    let text: String
    let value: Int
}

// MARK: - OverviewPolyline
struct OverviewPolyline {
    let points: String
}
