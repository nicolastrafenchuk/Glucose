//
//  ProfileDataStore.swift
//  Glucose
//
//  Created by Nicolas Trafenchuk on 29.11.2020.
//

import Foundation
import HealthKit

class ProfileDataStore {
    class func getMostRecentSample(for sampleType: HKSampleType,
        completion: @escaping (HKQuantitySample?, Error?) -> Swift.Void) {
        
        let mostRecentPredicate = HKQuery.predicateForSamples(
            withStart: Date.distantPast,
            end: Date(),
            options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(
            key: HKSampleSortIdentifierStartDate,
           ascending: false)
        
        let limit = 1
        
        let sampleQuery = HKSampleQuery(
            sampleType: sampleType,
           predicate: mostRecentPredicate,
           limit: limit,
           sortDescriptors: [sortDescriptor]) {
            (query, samples, error) in
               DispatchQueue.main.async {

                    guard let samples = samples,
                          let mostRecentSample = samples.first as? HKQuantitySample else {
                            completion(nil, error)
                            return
                        }
                
                    completion(mostRecentSample, nil)
               }
            
            }
        
        HKHealthStore().execute(sampleQuery)
        
    }
}

