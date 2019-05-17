//
//  User.swift
//  seguraarede
//
//  Created by Manuella Valença on 07/04/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//
import Foundation
import CoreLocation

extension Date {
    func isContained(within safeTime: SafeSpaceTime) -> Bool {
        let beginsAtOrAfterStartTime = Calendar.current.compare(self, to: safeTime.startTime, toGranularity: .minute) != ComparisonResult.orderedAscending
        let endsAtOrBeforeEndTime = Calendar.current.compare(self, to: safeTime.endTime, toGranularity: .minute) != ComparisonResult.orderedDescending
        return beginsAtOrAfterStartTime && endsAtOrBeforeEndTime
    }
}

extension CLLocationCoordinate2D {
    func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let origin = CLLocation(latitude: latitude, longitude: longitude)
        let destination = CLLocation(latitude: from.latitude,longitude: from.longitude)
        return origin.distance(from: destination)
    }
    
    func isContained(within safeLocation: SafeSpaceLocation) -> Bool {
        let distanceToLocation = self.distance(from: safeLocation.coordinates)
        return distanceToLocation < safeLocation.radius
    }
}

public class SafeSpaceUser {
    var safeTimes: [SafeSpaceTime] = []
    var safeLocations: [SafeSpaceLocation] = []
    
    public func isSafe() -> Bool {
        return isSafeTime() && isSafeLocation()
    }
    
    func isSafeTime() -> Bool {
        let currentDate = Date()
        
        for safeTime in safeTimes {
            if currentDate.isContained(within: safeTime) {
                return true
            }
        }
        
        return false
    }
    
    func isSafeLocation() -> Bool {
        let currentLocation = CLLocationCoordinate2D()
        
        for safeLocation in safeLocations {
            if currentLocation.isContained(within: safeLocation) {
                return true
            }
        }
        
        return false
    }
    
    public func insertTime(named name: String, startTime: Date, endTime: Date) {
        let safeTime = SafeSpaceTime(name: name, startTime: startTime, endTime: endTime)
        safeTimes.append(safeTime)
    }
    
    public func removeTime(named name: String) {
        safeTimes.removeAll {
            $0.name == name
        }
    }
    
    public func insertLocation(named name: String, coordinates: CLLocationCoordinate2D, radius: CLLocationDistance) {
        let safeLocation = SafeSpaceLocation(name: name, coordinates: coordinates, radius: radius)
        safeLocations.append(safeLocation)
    }
    
    public func removeLocation(named name: String) {
        safeLocations.removeAll {
            $0.name == name
        }
    }
}

let userSegura = SafeSpaceUser()
