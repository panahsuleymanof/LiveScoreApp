//
//  LoggedUser+CoreDataProperties.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 23.06.24.
//
//

import Foundation
import CoreData


extension LoggedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoggedUser> {
        return NSFetchRequest<LoggedUser>(entityName: "LoggedUser")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?

}

extension LoggedUser : Identifiable {

}
