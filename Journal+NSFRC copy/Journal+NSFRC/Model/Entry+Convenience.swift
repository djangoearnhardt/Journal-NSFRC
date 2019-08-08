//
//  Entry+Convenience.swift
//  Journal+NSFRC
//
//  Created by Karl Pfister on 5/9/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    /// Declare our convenience init. We are adding a default value for our MOC and Date. We call the memberwise init of Entry and initialize it with our context. 
    convenience init(title: String, body: String, timestamp: Date = Date(), context: NSManagedObjectContext = CoreDataStack.context) {
        // for memberwise initializer, we must call the memberwise within a convenience
        self.init(context: context)
        // for convenience initializer, this makes it easier on ourselves to use on the back end
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}
