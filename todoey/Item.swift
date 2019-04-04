//
//  Item.swift
//  todoey
//
//  Created by Mohamad Tarabishi on 4/2/19.
//  Copyright © 2019 Mohamad Tarabishi. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "Items")
    
    
}
