//
//  ChessPlayers+CoreDataProperties.swift
//  MokriyaChessChallenge
//
//  Created by Raja Ayyan on 23/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ChessPlayers {

    @NSManaged var currentrating: NSNumber?
    @NSManaged var image: String?
    @NSManaged var lastratings: NSObject?
    @NSManaged var name: String?

}
