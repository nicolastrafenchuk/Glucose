//
//  HistoryModel+CoreDataProperties.swift
//  Glucose
//
//  Created by Nicolas Trafenchuk on 29.11.2020.
//
//

import Foundation
import CoreData


extension HistoryModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryModel> {
        return NSFetchRequest<HistoryModel>(entityName: "HistoryModel")
    }

    @NSManaged public var measure: String!
    @NSManaged public var meal: String?
    @NSManaged public var date: String?

}

extension HistoryModel : Identifiable {

}
