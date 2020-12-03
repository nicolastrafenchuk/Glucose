//
//  HealthKitSetupAssistant.swift
//  Glucose
//
//  Created by Nicolas Trafenchuk on 29.11.2020.
//

import Foundation
import HealthKit

class HealthKitSetupAssistant {
    private enum HealthKitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void){
        guard HKHealthStore.isHealthDataAvailable() else {
                completion(false, HealthKitSetupError.notAvailableOnDevice)
                return
        }
        
        guard  let distanceCycling = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling),
        let distanceWalkingRunning = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning),
        let heartRate = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate),
        let distanceSwimming = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceSwimming)
        else {
            completion(false, HealthKitSetupError.dataTypeNotAvailable)
            return
        }

        let healthKitTypes: Set<HKSampleType> = [distanceCycling, distanceWalkingRunning, heartRate, distanceSwimming]
        
        HKHealthStore().requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) {
            (success, error) in  completion(success, error)
        }

        
    }
}
